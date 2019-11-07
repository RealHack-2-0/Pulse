const mongoose = require('../../common/services/mongoose.service').mongoose;
const Schema = mongoose.Schema;

const answerSchema = new Schema({
    authorId: String,
    questionId: String,
    content: String,
    isCorrect: Boolean
});

answerSchema.virtual('id').get(function () {
    return this._id.toHexString();
});

// Ensure virtual fields are serialised.
answerSchema.set('toJSON', {
    virtuals: true
});

answerSchema.findById = function (cb) {
    return this.model('Answers').find({ id: this.id }, cb);
};

const Answer = mongoose.model('Answers', answerSchema);


exports.findByQuestionId = (questionId) => {
    return Answer.find({ questionId: questionId });
};

exports.findById = (id) => {
    return Answer.findById(id)
        .then((result) => {
            result = result.toJSON();
            delete result._id;
            delete result.__v;
            return result;
        });
};

exports.createAnswer = (answerData) => {
    const answer = new Answer(answerData);
    return answer.save();
};

exports.markAsAnswer = (id) => {
    return new Promise((resolve, reject) => {
        Answer.findById(id, function (err, answer) {
            if (err) reject(err);
            answer.isCorrect = true;
            answer.save(function (err, updatedAnswer) {
                if (err) return reject(err);
                resolve(updatedAnswer);
            });
        });
    })
};

// exports.list = (perPage, page) => {
//     return new Promise((resolve, reject) => {
//         Answer.find()
//             .limit(perPage)
//             .skip(perPage * page)
//             .exec(function (err, answers) {
//                 if (err) {
//                     reject(err);
//                 } else {
//                     resolve(answers);
//                 }
//             })
//     });
// };

// exports.patchAnswer = (id, answerData) => {
//     return new Promise((resolve, reject) => {
//         Answer.findById(id, function (err, answer) {
//             if (err) reject(err);
//             for (let i in answerData) {
//                 answer[i] = answerData[i];
//             }
//             answer.save(function (err, updatedAnswer) {
//                 if (err) return reject(err);
//                 resolve(updatedAnswer);
//             });
//         });
//     })

// };

exports.removeById = (answerId) => {
    return new Promise((resolve, reject) => {
        Answer.remove({ _id: answerId }, (err) => {
            if (err) {
                reject(err);
            } else {
                resolve(err);
            }
        });
    });
};

