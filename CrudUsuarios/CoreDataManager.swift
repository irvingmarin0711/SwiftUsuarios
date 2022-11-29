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

    func guardarUsuario(id:Int, nombre:String, apellido:String, username:String, activo:Int, rolid:Int){
            let usuario = Usuario(context: persistentContainer.viewContext)
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
}
