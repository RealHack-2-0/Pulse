const AnswersController = require('./controllers/answers.controller');
const ValidationMiddleware = require('../common/middlewares/auth.validation.middleware');
const config = require('../common/config/env.config');

exports.routesConfig = function (app) {
    app.post('/answer/add', [
        ValidationMiddleware.validJWTNeeded,
        AnswersController.insert,
    ]);
    // app.get('/users', [
    //     ValidationMiddleware.validJWTNeeded,
    //     UsersController.list
    // ]);
    // app.get('/user/:userId', [
    //     ValidationMiddleware.validJWTNeeded,
    //     UsersController.getById
    // ]);
    // app.patch('/users/:userId', [
    //     ValidationMiddleware.validJWTNeeded,
    //     PermissionMiddleware.minimumPermissionLevelRequired(FREE),
    //     PermissionMiddleware.onlySameUserOrAdminCanDoThisAction,
    //     UsersController.patchById
    // ]);
    // app.delete('/users/:userId', [
    //     ValidationMiddleware.validJWTNeeded,
    //     PermissionMiddleware.minimumPermissionLevelRequired(ADMIN),
    //     UsersController.removeById
    // ]);
};
