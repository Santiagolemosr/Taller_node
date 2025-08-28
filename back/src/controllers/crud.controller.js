const db = require('../config/conexion_DB');

class crudcontroller{
 //obtener todos los registros de una tabla
    async obtenerTodos(tabla){
        const[resultados] = await db.query(`SELECT * FROM ${tabla}`);
        return resultados;
    }

    // obtener un registro por id
    async obtenerUno(tabla, idcampo, id){
        try{
            const[resultado] = await db.query(`SELECT * FROM ?? WHERE ?? = ?`,[tabla, idcampo, id]);
            return resultado[0];
        } catch (error) {
            throw error;
        }
        
    }
    //crear un nuevo registro

 async crear(tabla,data){
    try{
        const[resultado] = await db.query(`INSERT INTO ?? SET ?`,[tabla,data]);
        return{...data, id: resultado.insertId};
    }catch (error) {
        throw error;
    }
 }
    //actualizar un registro por id

    async actualizar(tabla, idcampo, id, data){
        try {
            const [resultado] = await db.query(`UPDATE ?? SET ? WHERE ?? = ?`,[tabla, data, idcampo, id]);
            if (resultado.affeectedrows === 0){
                throw new Error('Registro no encontrado');
            }
            return await this.obtenerUno(tabla, idcampo, id);
        }catch (error) {
            throw error;
        }
    }
        
     // Eliminar un registro por ID
     async eliminar(tabla, idcampo, id) {
        try {
            const[resultado] = await db.query(`DELETE FROM ?? WHERE ?? = ?`, [tabla, idcampo, id]);
            if(resultado.affeectedrows === 0) {
                throw new Error(`Registro no encontrado`);
            }
            return{message: 'registro eliminado exitosamente'};
        } catch(error) {
            throw error;
        }
     }

}
       
    

module.exports = crudcontroller;
