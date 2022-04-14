const Axios = require('axios');
const Ressource_type = require('../models/ressource_type')
let nomTest = 'ressource_type';
let i = 0;

test(nomTest+i+1+' : récupérer le nombre de type de ressource', async () => {
    const response = await Axios.get('http://localhost:3000/ressource_types')
    //console.log(response)
    expect(response.data.length).toEqual(8);
});

test(nomTest+i+1+' : poster un nouveau type de ressource', async () => {
    const response = await Axios.post('http://localhost:3000/admin/add-ressource_type',{
        label: "test"
    })
    //console.log(response.data)
    expect(response.data.label).toEqual("test");
});

test(nomTest+i+1+' : delete un nouveau type de ressource', async () => {
    const ressource_typeId = Ressource_type.destroy({ where: { label: 'test'}})
    console.log(await ressource_typeId)
    expect(await ressource_typeId).toEqual(1);
});