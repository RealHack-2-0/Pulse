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

exports.answerAdded = (questionId)=>{
    console.log('answer added for '+ questionId);
    global.nsp.emit('answer-added',questionId);
}

exports.myQuestionAnswered=(questionId,authorId)=>{
    global.nsp.emit('my-question-answered',{questionId:questionId,authorId:authorId});
}

// exports.sendNewQuestion = (questionId,userId)=>{
//     console.log('sending new question');
//     QuestionModel.findById(id)
//     .then((results)=>{
//         global.nsp.emit('refreshed_question',{userId:userId,question:results});
//     }

//     )
// }