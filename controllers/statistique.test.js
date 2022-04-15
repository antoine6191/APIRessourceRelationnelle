const Axios = require('axios');
const Statistique = require('../models/statistique')
let ressourceId = 3
let nomTest = 'statistique';
let i = 0;

test(nomTest+i+1+' : récupérer le nombre d enregistrement de satistique général', async () => {
    const response = await Axios.get('http://localhost:3000/admin/statistiques')
    expect(response.data.length).toEqual(10);
});

test(nomTest+i+1+' : récupérer le nombre de statistique pour la vue ayant l id '+ressourceId, async () => {
    const response = await Axios.get('http://localhost:3000/admin/statistiques/'+ressourceId)
    expect(response.data.length).toEqual(3);
});