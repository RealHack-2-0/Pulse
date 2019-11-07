const config = require('./common/config/env.config.js');
const notification = require('./socket/notification_socket');
const express = require('express');
const app = express();
var server = require('http').Server(app);
var io = require('socket.io')(server);

const QuestionModel = require('./questions/models/questions.model');
const AnswerModel = require('./answers/models/answers.model');



const bodyParser = require('body-parser');

const AuthorizationRouter = require('./authorization/routes.config');
const UsersRouter = require('./users/routes.config');
const QuestionsRouter = require('./questions/routes.config');
const AnswersRouter = require('./answers/routes.config')

app.use(function (req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Credentials', 'true');
    res.header('Access-Control-Allow-Methods', 'GET,HEAD,PUT,PATCH,POST,DELETE');
    res.header('Access-Control-Expose-Headers', 'Content-Length');
    res.header('Access-Control-Allow-Headers', 'Accept, Authorization, Content-Type, X-Requested-With, Range');
    if (req.method === 'OPTIONS') {
        return res.send(200);
    } else {
        return next();
    }
});

app.use(bodyParser.json());
AuthorizationRouter.routesConfig(app);
UsersRouter.routesConfig(app);
QuestionsRouter.routesConfig(app);
AnswersRouter.routesConfig(app);


server.listen(config.port, function () {
    console.log('app listening at port %s', config.port);
});



const nsp = io.of('/pulse');



global.nsp = nsp;
nsp.on('connection',function(socket){
    socket.join('pulse');
    socket.on('refreshed-question',function(data){
        console.log(data);
        QuestionModel.findById(data.id)
        .then((results)=>{
        socket.emit('refreshed-question',results);
        })
    });
    
    notification.sendAllQuestions();
    
    // setInterval(()=>{
    //     nsp.emit('msg-event','message from pulse');
    // },1000)
});

// nsp.on('refreshed-question',function(data){
//     console.log(data);
// })








