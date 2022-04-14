const Axios = require('axios');
const Role = require('../models/role')
let nomTest = 'role';
let i = 0;

test(nomTest+i+1+' : récupérer le nombre de role', async () => {
    const response = await Axios.get('http://localhost:3000/admin/roles')
    //console.log(response)
    expect(response.data.length).toEqual(3);
});