//
//  ContentView.swift
//  CrudUsuarios
//
//  Created by Lokura on 29/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let CoreDM: CoreDataManager
    @State var id=""
    @State var nombre=""
    @State var apellido=""
    @State var rolid=""
    @State var username=""
    @State var seleccionado:Usuario?
    @State var usArray=[Usuario]()
    
    var body: some View {
        VStack{
            TextField("Id", text: $id).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Nombre", text: $nombre).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Apellido", text: $apellido).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Rolid", text: $rolid).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Username", text: $username).textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Save"){
                if(seleccionado != nil){
                    seleccionado?.id=id
                    seleccionado?.nombre=nombre
                    seleccionado?.apellido=apellido
                    seleccionado?.rolid=rolid
                    seleccionado?.username=username
                    CoreDM.actualizaraUsuario(usuario: seleccionado!)
                }
