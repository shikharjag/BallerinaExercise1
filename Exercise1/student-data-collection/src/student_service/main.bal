  
import ballerina/http;
import Student;
//import ballerina/io;
//import ballerina/io;
#Student:person p = {};
//Student:OtherDetails f = {name:"S. Jagadeesh", full_name:"Shikhar", dob:"test"};
listener http:Listener listenerEndpoint = new(9090); //host 0.0.0.0:9090

service add on listenerEndpoint {

    @http:ResourceConfig {
        methods: ["POST"]
    }
    resource function addToTable(http:Caller caller, http:Request request) {
        map<string>|error sup =  request.getFormParams();
        
        if (sup is map<string>){
            
            Student:StudentDetails std = {name:sup.get("name"), full_name:sup.get("fullname"), dob:sup.get("dob"), gender:sup.get("gender")};
            Student:OtherDetails father = {name:sup.get("fname"), full_name:sup.get("ffullname"), dob:sup.get("fdob"), contact:sup.get("contact")};
            Student:student st = {sDetails:std, fDetails:father};
            Student:createDB();
            Student:addStudent(st);
        }
        
        
    }
}