const Axios = require('axios')
let ressourceId = 3;

test('récupérer le nombre de commentaires de la ressource '+ressourceId, async () => {
    const response = await Axios.get('http://localhost:3000/commits/'+ressourceId)
    //console.log(response)
    expect(response.data.length).toEqual(3);
});
