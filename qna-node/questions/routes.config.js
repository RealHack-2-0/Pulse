const QuestionsController = require('./controllers/questions.controller');
const ValidationMiddleware = require('../common/middlewares/auth.validation.middleware');
const config = require('../common/config/env.config');

exports.routesConfig = function (app) {
    app.post('/questions/add', [
        ValidationMiddleware.validJWTNeeded,
        QuestionsController.insert
    ]);
    app.get('/questions/list', [
        ValidationMiddleware.validJWTNeeded,
        QuestionsController.list
    ]);
    app.get('/question/:id', [
        ValidationMiddleware.validJWTNeeded,
        QuestionsController.getById
    ]);
    app.post('/question/:id/upvote', [
        ValidationMiddleware.validJWTNeeded,
        QuestionsController.upvoteQuestion
    ]);
    app.post('/question/:id/downvote', [
        ValidationMiddleware.validJWTNeeded,
        QuestionsController.downvoteQuestion
    ]);
    app.get('/questions/by/:id', [
        ValidationMiddleware.validJWTNeeded,
        QuestionsController.getByAuthorId
    ]);
};
