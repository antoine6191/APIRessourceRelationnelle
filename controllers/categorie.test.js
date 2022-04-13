const Axios = require('axios')
let categorieId = 1;

test('récupérer la catégorie ayant l id '+categorieId, async () => {
    const response = await Axios.get('http://localhost:3000/categorie/'+categorieId)
    console.log(response.data)
    expect(response.data).toEqual({createdAt: "2022-03-16T13:19:33.000Z",id: 1,label: "communication",updatedAt: "2022-03-16T13:19:33.000Z"});
});
