const Axios = require('axios')
const Commit = require('../models/commit')
let ressourceId = 3;
let nomTest = 'commit';
let i = 0;

test(nomTest+i+1+' : récupérer le nombre de commentaires de la ressource '+ressourceId, async () => {
    const response = await Axios.get('http://localhost:3000/commits/'+ressourceId)
    expect(response.data.length).toEqual(3);
});

test(nomTest+i+1+' : poster un nouveau commentaire', async () => {
    const response = await Axios.post('http://localhost:3000/add-commit',{
        texte:"testtesttest",
        user_id: 1,
        ressource_id: 2
    })
    expect(response.data.texte).toEqual("testtesttest");
});

test(nomTest+i+1+' : delete un nouveau commentaire', async () => {
    const categorieId = Commit.destroy({ where: { texte: "testtesttest"}})
    expect(await categorieId).toEqual(1);
});
