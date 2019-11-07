const mongoose = require('../../common/services/mongoose.service').mongoose;
const Schema = mongoose.Schema;

const questionSchema = new Schema({
    authorId: String, // Auto
    title: String,
    content: String,
    upvotes: [String], // Auto
    downvotes: [String], // Auto
    resolved: Boolean, // Auto
    correctAnswerId: String // Auto
});

questionSchema.virtual('id').get(function () {
    return this._id.toHexString();
});

// Ensure virtual fields are serialised.
questionSchema.set('toJSON', {
    virtuals: true
});

questionSchema.findById = function (cb) {
    return this.model('Questions').find({ id: this.id }, cb);
};

const Question = mongoose.model('Questions', questionSchema);


exports.findByAuthorId = (id) => {
    return Question.find({ authorId: id });
};

exports.findById = (id) => {
    return Question.findById(id)
        .then((result) => {
            result = result.toJSON();
            delete result._id;
            delete result.__v;
            return result;
        });
};

exports.createQuestion = (questionData) => {
    const question = new Question(questionData);
    return question.save();
};

exports.list = (perPage, page) => {
    return new Promise((resolve, reject) => {
        Question.find()
            .limit(perPage)
            .skip(perPage * page)
            .exec(function (err, Questions) {
                if (err) {
                    reject(err);
                } else {
                    resolve(Questions);
                }
            })
    });
};

exports.upvoteQuestion = (id, userId) => {
    return new Promise((resolve, reject) => {
        Question.findById(id, function (err, question) {
            if (err) reject(err);

            if (question.downvotes.includes(userId)) {
                var downvotes = Object.assign([], question.downvotes)
                question.downvotes = downvotes.filter(vote => vote != userId);
            }
            if (!question.upvotes.includes(userId)) {
                question.upvotes.push(userId);
            }
            question.save(function (err, updatedQuestion) {
                if (err) return reject(err);
                resolve(updatedQuestion);
            });
        });
    })
};

exports.downvoteQuestion = (id, userId) => {
    return new Promise((resolve, reject) => {
        Question.findById(id, function (err, question) {
            if (err) reject(err);
            if (question.upvotes.includes(userId)) {
                var upvotes = Object.assign([], question.upvotes)
                question.upvotes = upvotes.filter(vote => vote != userId);
            }
            if (!question.downvotes.includes(userId)) {
                question.downvotes.push(userId);
            }
            question.save(function (err, updatedQuestion) {
                if (err) return reject(err);
                resolve(updatedQuestion);
            });
        });
    })
};

// exports.removeById = (QuestionId) => {
//     return new Promise((resolve, reject) => {
//         Question.remove({ _id: QuestionId }, (err) => {
//             if (err) {
//                 reject(err);
//             } else {
//                 resolve(err);
//             }
//         });
//     });
// };

