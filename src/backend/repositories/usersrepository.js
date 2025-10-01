const pool = require(`../config/db`);

class UserRepository{

    async FindUsers(email){
       const result = await pool.query(`Select * From users Where email = $1`, [email]); 
       return result.rows[0] || null;
    }

    async findById(user_id) {
        const result = await pool.query('SELECT * FROM users WHERE user_id = $1', [user_id]);
        return result.rows[0] || null;
    }

    async CreateUser(UserData){
        const { login_name, email, password } = UserData;

        const result = await pool.query(`Insert Into users (login_name, email, password) Values ($1, $2, $3) Returning *`, 
            [login_name, email, password])

        return result.rows[0];
    }

}

module.exports = new UserRepository();