class RoadMapListMdl {
    constructor(con){
        this.con = con;
    }

    // Récupération des RoadMap en BDD
    async getAllRoadMaps(){
        return new Promise((resolve, reject) => {
            this.con.db.query('select * from roadmaps', [], (err, results) => {
                if(err) throw err;
                if(results === undefined){
                    reject(new Error('Undifined'));
                } else {
                    resolve(results);
                }
            });
        });
    }

    // Suppression d'une RoadMap en BDD
    async deleteRoadMaps(id){
        return new Promise((resolve, reject) => {
            this.con.db.query('DELETE FROM roadmaps WHERE id = ' + id, [], (err, results) => {
                if(err) throw err;
                if(results === undefined){
                    reject(new Error('Error'));
                } else {
                    resolve(results);
                }
            });
        });
    }

    // Création d'une RoadMap en BDD
    async createRoadMap(name, password, nbrParticipants, location, startDate, endDate, budget, leader){
        return new Promise((resolve, reject) => {
            this.con.db.query(`INSERT INTO roadmaps (name, password, nbr_participants, location, startDate, endDate, budget, leader)
            VALUES ('${name}', '${password}', ${nbrParticipants}, '${location}', '${startDate}', '${endDate}', ${budget}, ${leader});`, [], (err, results) => {
                if(err) throw err;
                if(results === undefined){
                    reject(new Error('Error'));
                } else {
                    resolve(results);
                }
            });
        });
    }
}
module.exports = RoadMapListMdl;
