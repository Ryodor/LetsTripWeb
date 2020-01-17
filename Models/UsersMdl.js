class UsersMdl {
    constructor(con) {
        this.con = con;
    }

    /**
     * @return {Promise} The promise who will allow us to get the data
     */

    async newUser(last_name, first_name, email, password) {
        return new Promise((resolve, reject) => {
            this.con.db.query(
                `insert into users (email, pseudo, creation_date, is_active, firstname, lastname) 
                values 
                ("${email}", "", now(), true, "${first_name}", "${last_name}");`, [], (err, results) => {
                    if (err) throw err;
                    if (results === undefined) {
                        reject(new Error("Undefined"));
                    } else {
                        resolve(results);
                    }
                });
        });
    }
}

module.exports = UsersMdl;