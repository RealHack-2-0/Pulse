const AnswerModel = require('../models/answers.model');

exports.insert = (req, res) => {
    // TODO: Offesive words censoring
    req.body.authorId = req.jwt.userId;
    req.body.isCorrect = false;

    AnswerModel.createAnswer(req.body)
        .then((result) => {
            res.status(201).send({ id: result._id });
        });
};

exports.list = (req, res) => {
    questionId = res.body.questionId;

    let limit = req.query.limit && req.query.limit <= 100 ? parseInt(req.query.limit) : 10;
    let page = 0;
    if (req.query) {
        if (req.query.page) {
            req.query.page = parseInt(req.query.page);
            page = Number.isInteger(req.query.page) ? req.query.page : 0;
        }
    }
    AnswerModel.list(limit, page, questionId)
        .then((result) => {
            res.status(200).send(result);
        })
};

// ! id(question id) field required
exports.getById = (req, res) => {
    AnswerModel.findById(req.params.id)
        .then((result) => {
            res.status(200).send(result);
        });
};

// ! id(author id) field required
exports.getByAuthorId = (req, res) => {
    AnswerModel.findByAuthorId(req.params.id)
        .then((result) => {
            res.status(200).send(result);
        });
};

exports.upvoteAnswer = (req, res) => {
    AnswerModel.upvoteAnswer(req.params.id, req.jwt.userId)
        .then((result) => {
            res.status(204).send({});
        });
};

exports.downvoteAnswer = (req, res) => {
    AnswerModel.downvoteAnswer(req.params.id, req.jwt.userId)
        .then((result) => {
            res.status(204).send({});
        });
};

// exports.removeById = (req, res) => {
//     AnswerModel.removeById(req.params.userId)
//         .then((result) => {
//             res.status(204).send({});
//         });
// };