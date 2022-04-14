const Axios = require('axios');
const Statistique = require('../models/statistique')
let ressourceId = 3
let nomTest = 'role';
let i = 0;

test(nomTest+i+1+' : récupérer le nombre d enregistrement de satistique', async () => {
    const response = await Axios.get('http://localhost:3000/admin/statistiques')
    //console.log(response)
    expect(response.data.length).toEqual(10);
});


test(nomTest+i+1+' : récupérer le nombre de statistique pour une vue', async () => {
    const response = await Axios.get('http://localhost:3000/admin/statistiques/'+ressourceId)
    //console.log(response)
    expect(response.data.length).toEqual(3);
});