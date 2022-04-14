const Axios = require('axios');
const Favoris = require('../models/favoris');
let userId = 3;
let nomTest = 'favoris';
let i = 0;

test(nomTest+i+1+' : récupérer le nombre de favoris du user '+userId, async () => {
    const response = await Axios.get('http://localhost:3000/favoris/'+userId)
    expect(response.data.length).toEqual(2);
});


test(nomTest+i+1+' : ajouter une ressource en favoris', async () => {
    const response = await Axios.post('http://localhost:3000/add-favoris',{
        favoris: true,
        user_id: 4,
        ressource_id: 2
    })
    expect(response.data.favoris).toEqual(true);
});

test(nomTest+i+1+' : delete un favoris', async () => {
    const favorisId = Favoris.destroy({ where: { user_id: 4}})
    expect(await favorisId).toEqual(1);
});
