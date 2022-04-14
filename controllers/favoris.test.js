const Axios = require('axios')
let userId = 3;
let nomTest = 'favoris';
let i = 0;

test(nomTest+i+1+' : récupérer le nombre de favoris du user '+userId, async () => {
    const response = await Axios.get('http://localhost:3000/favoris/'+userId)
    //console.log(response)
    expect(response.data.length).toEqual(2);
});

