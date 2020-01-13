import ballerinax/java.jdbc;
import ballerina/io;

const string MALE = "MALE";
const string FEMALE = "FEMALE";
const string YES= "YES";
const string NO = "NO";
const string GOV = "GOVERNMENT";
const string PRIV = "PRIVATE";
public type Person record {
    string name;
    string full_name;
    string dob;

};

public type StudentDetails record {
    *Person;

    string gender;

};
public function create_table(){
    var ret = testDB->update("CREATE TABLE STUDENTS () ");
}
public type OtherDetails record {
    *Person;

    string contact;
};

public type student record {|
    StudentDetails sDetails;
    OtherDetails fDetails;
    OtherDetails mDetails?;
    OtherDetails gDetails?;
|};

jdbc:Client testDB = new ({
    url: "jdbc:h2:file:./db_files/demodb",
    username: "test",
    password: "test"
});

public function createDB(){
    string squery = "CREATE TABLE STUDENT (NAME_INITIAL VARCHAR(255), FULLNAME VARCHAR(255), DOB VARCHAR(255), GENDER VARCHAR(255), FATHER_NAME_I VARCHAR(255), FATHER_FULL_NAME VARCHAR(255), FATHER_DOB VARCHAR(255))";
    var ret = testDB->update(squery);
    handleUpdate(ret, "Create CUSTOMER table");

}

public function addStudent(student stud){
    string squery="INSERT INTO STUDENT (NAME_INITIAL, FULLNAME,DOB, GENDER, FATHER_NAME_I, FATHER_FULL_NAME, FATHER_DOB) VALUES (?,?,?,?,?,?,?)";
    var ret = testDB->update(squery, stud.sDetails.name, stud.sDetails.full_name, stud.sDetails.dob, stud.sDetails.gender, stud.fDetails.name, stud.fDetails.full_name, stud.fDetails.dob);
    handleUpdate(ret, "Insert data to CUSTOMER table");

}

function handleUpdate(jdbc:UpdateResult|error returned, string message) {
    if (returned is jdbc:UpdateResult) {
        io:println(message + " status: ", returned.updatedRowCount);
    } else {
        io:println(message + " failed: ", <string>returned.detail()?.message);
    }
}


