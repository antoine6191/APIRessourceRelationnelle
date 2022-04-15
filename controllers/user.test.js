const Axios = require('axios');
const User = require('../models/user')
let userId = 3
let nomTest = 'user';
let i = 0;

test(nomTest+i+1+' : récupérer le nombre de user', async () => {
    const response = await Axios.get('http://localhost:3000/admin/users')
    expect(response.data.length).toEqual(4);
});


test(nomTest+i+1+' : récupérer le user ayant l id'+userId, async () => {
    const response = await Axios.get('http://localhost:3000/user/'+userId)
    expect(response.data.nom).toEqual("poyeau");
});

