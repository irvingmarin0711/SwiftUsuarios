//
//  CoreDataManager.swift
//  CrudUsuarios
//
//  Created by Lokura on 29/11/22.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer : NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "CrudUsuarios")
        persistentContainer.loadPersistentStores(completionHandler: {
            (description, error) in
            if let error = error {
                fatalError("Corre data failed to initialized (error.localizedDescription)")
            }
            
        })
    }
    
    func guardarUsuario(id:Int64, nombre:String, apellido:String, username:String, activo:Int64, rolid:Int64){
        let usuario = Usuario(context : persistentContainer.viewContext)
        usuario.id = id
        usuario.nombre = nombre
        usuario.apellido = apellido
        usuario.username = username
        usuario.activo = activo
        usuario.rolid = rolid
        
        do {
            try persistentContainer.viewContext.save()
            print("Usuario agregado con éxito")
        }
        catch{
            print("Error al guardar el usuario en (error)")
        }
    }
    
    func leerTodosLosUsuarios()-> [Usuario]{
        let fetchRequest:NSFetchRequest<Usuario>=Usuario.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return[]
        }
    }
    func leerUsuario(id:String)->Usuario?{
        let fetchRequest:NSFetchRequest<Usuario>=Usuario.fetchRequest()
        let predicate = NSPredicate(format:"id=%@",id)
        fetchRequest.predicate=predicate
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
        }
        catch{
            print("failed to  save error en \(error)")
        }
        return nil
        
    }
    func actualizarUsuario(usuario:Usuario){
        //var ped=persistentContainer.viewContext.updatedObjects([pedido])
        let fetchRequest:NSFetchRequest<Usuario>=Usuario.fetchRequest()
        let predicate = NSPredicate(format:"id=%@",usuario.id ?? "")
        fetchRequest.predicate=predicate
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let u=datos.first
            u?.nombre=usuario.nombre
            u?.apellido=usuario.apellido
            u?.rolid=usuario.rolid
            u?.id=usuario.id
            u?.username=usuario.username
            try persistentContainer.viewContext.save()
            print("usuario guardado")
        }
        catch{
            print("failed to  save error en \(error)")
        }
        
    }

}
