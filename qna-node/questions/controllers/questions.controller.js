const QuestionModel = require('../models/questions.model');

exports.insert = (req, res) => {
    // TODO: Offesive words censoring
    req.body.authorId = req.jwt.userId;
    req.body.upvotes = 0;
    req.body.downvotes = 0;
    req.body.resolved = false;
    req.body.correctAnswerId = null;

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

// exports.patchById = (req, res) => {
//     if (req.body.password) {
//         let salt = crypto.randomBytes(16).toString('base64');
//         let hash = crypto.createHmac('sha512', salt).update(req.body.password).digest("base64");
//         req.body.password = salt + "$" + hash;
//     }

//     QuestionModel.patchQuestion(req.params.userId, req.body)
//         .then((result) => {
//             res.status(204).send({});
//         });

// };

// exports.removeById = (req, res) => {
//     QuestionModel.removeById(req.params.userId)
//         .then((result) => {
//             res.status(204).send({});
//         });
// };