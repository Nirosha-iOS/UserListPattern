//
//  ContentView.swift
//  UserListPattern
//
//  Created by KISHANI on 17/05/24.


/*
 Text(user.name).font(.headline)
 Text(user.email).font(.subheadline)
 Text("Gender: \(user.gender.capitalized)").font(.subheadline)
 Text("Status: \(user.status.capitalized)").font(.subheadline)
 
 */
//
import SwiftUI

struct ContentView: View {
    @StateObject private var mvcController = UserController()
    @StateObject private var mvvmViewModel = UserViewModel()
    
    @State private var isMVVM = false
    
    var body: some View {
        VStack {
            Picker("Pattern", selection: $isMVVM) {
                Text("MVC").tag(false)
                Text("MVVM").tag(true)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if isMVVM {
                UserListView(viewModel: mvvmViewModel)
            } else {
                UserListView(viewModel: mvcController)
            }
        }
    }
}

struct UserListView<T: UserProtocol>: View {
    @ObservedObject var viewModel: T

    var body: some View {
        List(viewModel.users) { user in
            VStack(alignment: .leading) {
                Text(user.name).font(.headline)
                Text(user.email).font(.subheadline)
                Text("Gender: \(user.gender.capitalized)").font(.subheadline)
                Text("Status: \(user.status.capitalized)").font(.subheadline)
                
            }
        }
        .onAppear {
            viewModel.fetchUsers()
        }
        .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

