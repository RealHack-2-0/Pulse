const QuestionsController = require('./controllers/questions.controller');
const ValidationMiddleware = require('../common/middlewares/auth.validation.middleware');
const config = require('../common/config/env.config');

exports.routesConfig = function (app) {
    app.post('/questions/add', [
        ValidationMiddleware.validJWTNeeded,
        QuestionsController.insert
    ]);
    app.get('/questions', [
        ValidationMiddleware.validJWTNeeded,
        QuestionsController.list
    ]);
    app.get('/question/:id', [
        ValidationMiddleware.validJWTNeeded,
        QuestionsController.getById
    ]);
    app.get('/questions/by/:id', [
        ValidationMiddleware.validJWTNeeded,
        QuestionsController.getByAuthorId
    ]);
};
