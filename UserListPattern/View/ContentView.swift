//
//  ContentView.swift
//  UserListPattern
//
//  Created by KISHANI on 17/05/24.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var mvcController = UserController()
    @StateObject private var mvvmViewModel = UserViewModel()
    @StateObject private var mvpPresenter = UserPresenter()

    @State private var viewPattern: any UserProtocol
    
    init() {
        // Temporary workaround to initialize viewPattern
        _viewPattern = State(initialValue: UserController() as any UserProtocol)
    }

    var body: some View {
        NavigationView {
            List(viewPattern.users) { user in
                VStack(alignment: .leading) {
                    Text(user.name).font(.headline)
                    Text(user.email).font(.subheadline)
                    Text("Gender: \(user.gender.capitalized)").font(.subheadline)
                    Text("Status: \(user.status.capitalized)").font(.subheadline)
                }
            }
            .navigationBarTitle("Users")
            .onAppear {
                viewPattern.fetchUsers()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: togglePattern) {
                        Text("Now Pattern is \(viewPattern is UserController ? "MVC" : viewPattern is UserViewModel ? "MVVM" : "MVP")")
                    }
                }
            }
        }
        .alert(isPresented: .constant(viewPattern.errorMessage != nil)) {
            Alert(title: Text("Error"), message: Text(viewPattern.errorMessage ?? ""), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            // Properly set the initial viewPattern once the view appears
            viewPattern = mvcController
        }
    }
    
    private func togglePattern() {
        if viewPattern is UserController {
            viewPattern = mvvmViewModel
        } else {
            viewPattern = mvcController
        }
        
        
        /*
         
         else if viewPattern is UserViewModel {
             viewPattern = mvpPresenter
         } else {
             viewPattern = mvcController
         }
         
         */
        viewPattern.fetchUsers()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

