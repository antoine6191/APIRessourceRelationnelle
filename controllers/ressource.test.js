const Axios = require('axios');
const Ressource = require('../models/ressource')
let ressourceId = 3
let nomTest = 'ressource';
let i = 0;

test(nomTest+i+1+' : récupérer le nombre de type de ressource', async () => {
    const response = await Axios.get('http://localhost:3000/ressources')
    expect(response.data.length).toEqual(5);
});

test(nomTest+i+1+' : récupérer la ressource n° '+ressourceId, async () => {
    const response = await Axios.get('http://localhost:3000/ressources/'+ressourceId)
    expect(response.data.titre).toEqual('Le rire au travail et l’éthique');
});

test(nomTest+i+1+' : poster un nouvelle ressource', async () => {
    const response = await Axios.post('http://localhost:3000/add-ressource',{
        titre: "test",
        description: "test",
        categorie_id: 5,
        relation_types_id: 1,
        ressource_types_id: 5,
        user_id: 1
    })
    expect(response.data.relation_types_id).toEqual("test");
});

test(nomTest+i+1+' : delete un nouveau type de ressource', async () => {
    const ressourceId = Ressource.destroy({ where: { titre: 'test'}})
    expect(await ressourceId).toEqual(1);
});
