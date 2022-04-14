const Axios = require('axios');
const Relation_type = require('../models/relation_type')
let nomTest = 'relation_type';
let i = 0;

test(nomTest+i+1+' : récupérer le nombre de type de relation du user ', async () => {
    const response = await Axios.get('http://localhost:3000/relation_types')
    //console.log(response)
    expect(response.data.length).toEqual(6);
});

test(nomTest+i+1+' : poster un nouveau type de relation', async () => {
    const response = await Axios.post('http://localhost:3000/admin/add-relation_type',{
        label: "test"
    })
    //console.log(response.data)
    expect(response.data.label).toEqual("test");
});

test(nomTest+i+1+' : delete un nouveau type de relation', async () => {
    const relation_typeId = Relation_type.destroy({ where: { label: 'test'}})
    console.log(await relation_typeId)
    expect(await relation_typeId).toEqual(1);
});