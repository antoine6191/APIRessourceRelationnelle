const Axios = require('axios')
const Categorie = require('../models/categorie')
let categorieId = 1;
let nomTest = 'categorie';
let i = 0;

test(nomTest+i+1+' : récupérer la catégorie ayant l id '+categorieId, async () => {
    const response = await Axios.get('http://localhost:3000/categorie/'+categorieId)
    //console.log(response)
    expect(response.data.label).toEqual("communication");
});

test(nomTest+i+1+' : poster une nouvelle catégorie', async () => {
    const response = await Axios.post('http://localhost:3000/admin/add-categorie',{
        label:"test"
    })
    //console.log(response.data)
    expect(response.data.label).toEqual("test");
});

test(nomTest+i+1+' : delete une nouvelle catégorie', async () => {
    const categorieId = Categorie.destroy({ where: { label: "test"}})
    //console.log(await categorieId)
    expect(await categorieId).toEqual(1);
});

test(nomTest+i+1+' : récupérer le nombre de catégorie', async () => {
    const response = await Axios.get('http://localhost:3000/categories')
    //console.log(response.data)
    expect(response.data.length).toEqual(13);
});