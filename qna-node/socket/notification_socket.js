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

exports.sendNewQuestion = (questionId,userId)=>{
    console.log('sending new question');
    QuestionModel.findById(id)
    .then((results)=>{
        global.nsp.emit('refreshed_question',{userId:userId,question:results});
    }

    )
}