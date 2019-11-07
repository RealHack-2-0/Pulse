const QuestionModel = require('../models/questions.model');
const BadWords = require('bad-words');
var wordsFilter = new BadWords();


exports.insert = (req, res) => {
    // TODO: Offesive words censoring
    req.body.authorId = req.jwt.userId;
    req.body.upvotes = [];
    req.body.downvotes = [];
    req.body.resolved = false;
    req.body.correctAnswerId = null;
    req.body.content = wordsFilter.clean(req.body.content);
    req.body.title = wordsFilter.clean(req.body.title)

    QuestionModel.createQuestion(req.body)
        .then((result) => {
            res.status(201).send({ id: result._id });
        });
};

exports.list = (req, res) => {
    let limit = req.query.limit && req.query.limit <= 100 ? parseInt(req.query.limit) : 10;
    let page = 0;
    if (req.query) {
        if (req.query.page) {
            req.query.page = parseInt(req.query.page);
            page = Number.isInteger(req.query.page) ? req.query.page : 0;
        }
    }
    QuestionModel.list(limit, page)
        .then((result) => {
            res.status(200).send(result);
        })
};

// ! id(question id) field required
exports.getById = (req, res) => {
    QuestionModel.findById(req.params.id)
        .then((result) => {
            res.status(200).send(result);
        });
};

// ! id(author id) field required
exports.getByAuthorId = (req, res) => {
    QuestionModel.findByAuthorId(req.params.id)
        .then((result) => {
            res.status(200).send(result);
        });
};

exports.upvoteQuestion = (req, res) => {
    QuestionModel.upvoteQuestion(req.params.id, req.jwt.userId)
        .then((result) => {
            res.status(204).send({});
        });
};

exports.downvoteQuestion = (req, res) => {
    QuestionModel.downvoteQuestion(req.params.id, req.jwt.userId)
        .then((result) => {
            res.status(204).send({});
        });
};

// exports.removeById = (req, res) => {
//     QuestionModel.removeById(req.params.userId)
//         .then((result) => {
//             res.status(204).send({});
//         });
// };