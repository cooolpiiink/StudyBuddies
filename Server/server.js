var express = require('express');
var router = express.Router();
var options = {promiseLib: Promise};
var pgp = require('pg-promise')(options);
var pg = require('pg');
var path = require('path');
var connectionString = 'postgres://postgres:12345@localhost:5432/studybuddies';
var app = express();
var fs = require('fs');
var URL = require('url-parse');
var url = require('url');
const results=[];


var client = new pg.Client(connectionString);
client.connect();

//for create group
app.get("/studybuddies/groupchat/insert/:gname/:uid", function(req,res){
	client.query("insert into groupchat(groupname) values ('"+req.params.gname+"');");

	var data = "Halloo!!"
	fs.writeFile("C:/Users/Pauline Sarana/Desktop/studybuddies/StudyBuddies/Server/testing/"+req.params.gname+".txt", data, function (err) {
    if (err) 
        return console.log(err);
    console.log('file created');
	});

	var groupid = client.query("select groupid from groupchat where groupname = '" + req.params.gname+ "';", function (err, result){
		console.log(result.rows[0].groupid);
		client.query("insert into junctable (userid, groupid) values (" + req.params.uid + "," + result.rows[0].groupid +");");

	});

	//client.query("insert into junctable (userid, groupid) values (" + req.params.uid + "," + groupid+");");

	console.log('Insert groupname in groupchat');
	res.send('Inserted '+req.params.gname+' into groupchat');
});

//for registration of user, insert into buddy
app.get("/studybuddies/buddy/insert/:username/:password/:fname/:lname", function(req,res){
	client.query("insert into buddy(username,password,fname,lname) values ('"+req.params.username+"','"+req.params.password+"','"+req.params.fname+"','"+req.params.lname+"');");
	console.log('Insert into buddy');
	res.send('Inserted '+req.params.username+' into buddy');
}); 

//for log-in
app.get("/studybuddies/buddy/login/:username/:password", function(req, res){
	var results = [];

	var queryString = client.query("SELECT * from buddy where username ='" + req.params.username + "' and password = '" + req.params.password+ "';");

	queryString.on('row', (row) => {
		results.push(row);
	});

	queryString.on('end', () => {
		return res.send(JSON.stringify(results));
		done();
	});
	console.log('Logging In');
});

//pag view sa mga groupname
app.get("/viewGroups",function(req,res){

	var results = [];
	var query = client.query("SELECT groupname from groupchat");

	query.on('row', (row) => {
      results.push(row);
    });
    query.on('end', () => {
      return res.send({'chat':results});
      done();
    });    
    console.log("viewing..");
});

//wala pa ni
app.get("/studybuddies/groupchat/select", function(req, res){
	client.query("select * from groupchat", function(err, rows, fields){
		if(!err){
			res.send("Selected");
			console.log(rows);
		}else{
			console.log('No results.');
		}
	});
});

app.listen(8080, function(){
	console.log("Server at port 8080");
});