const Categorie = require('./categorie')
const Axios = require('axios')
let categorieId = 1;

test('récupérer la catégorie ayant l id '+categorieId, () => {
  expect(Axios.get('localhost:3000/categorie/'+categorieId)).toBe(res.then.data({
        "id": 1,
        "label": "communication",
        "createdAt": "2022-03-16T13:19:33.000Z",
        "updatedAt": "2022-03-16T13:19:33.000Z"
  }));
});