const QuestionModel = require('../questions/models/questions.model');


// exports.nsp = {};

// const nsp = io.of('/pulse');

exports.sendAllQuestions = ()=>{
    // var output={};
    console.log('sending all q');
    QuestionModel.list()
    .then((results)=>{
        global.nsp.emit('all-questions',results);
    })
    
}