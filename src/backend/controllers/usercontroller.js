const UserService = require(`../servises/userservice`);

class usercontroller{
    async register(req, res){
        const user = await UserService.register(req.body);
        res.status(201).json(user);
    } catch (error) {
            res.status(400).json({ message: error.message });
        };

    async login(req, res){
        const user = await UserService.login(req.body);
        res.status(201).json(user);
    } catch (error) {
            res.status(400).json({ message: error.message });
        };
}

module.exports = new usercontroller()