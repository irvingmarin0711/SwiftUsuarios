//
//  CoreDataManager.swift
//  ExamenPedidos
//
//  Created by Lokura on 29/11/22.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistenContainer : NSPersistentContainer

    init(){
        persistenContainer = NSPersistentContainer(name: "Pedido")
        persistenContainer.loadPersistentStores(completionHandler: {
            (description, error) in
            if let error = error {
                fatalError("error en core data al inicializar \(error.localizedDescription)")
            }
    })

    func GuardarPedido(nombre: String, articulo: String, dirección: String, estatus: String, fecha: String, total: String){
        let pedido = Pedidos(context: persistenContainer.viewContext)
        pedido.nombre = nombre
        pedido.articulo = articulo
        pedido.direccion = dirección
        pedido.estatus = estatus
        pedido.fecha = fecha
        pedido.total = total

        do{
            try persistenContainer.viewContext.save()
            print("Pedido Guardado")
        } catch {
            print("Fallo al Guardar en \(error)")
        }

    }

    func leerTodos() -> [Pedidos] {
        let request : NSFetchRequest<Pedidos> = Pedidos.fetchRequest()

        do{
            return try persistenContainer.viewContext.fetch(request)
        } catch {
            return []
        }
    }

    func EliminarPedido(pedido : Pedidos){
        persistenContainer.viewContext.delete(pedido)

        do {
            try persistenContainer.viewContext.save()
        } catch {
            persistenContainer.viewContext.rollback()
            print("Fallo al Eliminar en \(error.localizedDescription)")
        }

    }

    func ActualizaPedido(pedido: Pedidos) {
        let fetchRequest : NSFetchRequest<Pedidos> = Pedidos.fetchRequest()
        let predicate = NSPredicate(format:"Nombre = %@", pedido.nombre ?? "")
        fetchRequest.predicate = predicate

        do{
            let datos = try persistenContainer.viewContext.fetch(fetchRequest)
            let p = datos.first
            p?.nombre = pedido.nombre
            p?.articulo = pedido.articulo
            p?.direccion = pedido.direccion
            p?.estatus = pedido.estatus
            p?.fecha = pedido.fecha
            p?.total = pedido.total

            try persistenContainer.viewContext.save()
            print("Producto Actualizado")
        } catch {
            print("Error al Actualizar \(error)")
        }
    }

    func leerUno(nombre: String) -> Pedidos?{
        let fetchRequest : NSFetchRequest<Pedidos> = Pedidos.fetchRequest()
        let predicate = NSPredicate(format:"Nombre = %@", nombre)
        fetchRequest.predicate = predicate

        do{
            let datos = try persistenContainer.viewContext.fetch(fetchRequest)
            return datos.first
        } catch {
            print("Error al Actualizar \(error)")
        }
        return nil
    }
}
}
