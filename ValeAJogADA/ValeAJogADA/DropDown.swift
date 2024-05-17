import SwiftUI

struct DropDown: View {
    @State private var searchText = ""
    @State private var isDropdownPresented = false
    @State private var selectedItem: String? = nil
    private var items: [String] = ["Apple", "Banana", "Orange", "Grape", "Strawberry"]

    var filteredItems: [String] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isDropdownPresented.toggle()
                }
            }) {
                //if !isDropdownPresented {
                    HStack {
                        Text(selectedItem ?? "Select an item")
                            .foregroundColor(selectedItem == nil ? .gray : .black)
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                //}
            }
            
            if isDropdownPresented {
                VStack {
                    TextField("Search...", text: $searchText)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    List(filteredItems, id: \.self) { item in
                        Button(action: {
                            selectedItem = item
                            withAnimation {
                                isDropdownPresented.toggle()
                            }
                        }) {
                            Text(item)
                        }
                    }
                    .frame(height: 150) // Limit the height of the dropdown
                }
                .transition(.opacity)
            }
        }
        .padding()
        .frame(width: 165)
    }
}
