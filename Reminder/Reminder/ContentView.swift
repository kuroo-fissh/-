//
//  ContentView.swift
//  Reminder
//
//  Created by 鱼 on 2022/3/11.
//

import SwiftUI
import UIKit

struct Reminders{
    var ItemName : String
    var Chosen : Bool
    var Catagory : String
}

struct Priority{
    var name : String
    var chosen : Bool
}

struct ReminderLists{
    var name : String
    var chosen : Bool
}

struct ColorPalette{
    var color : Color
    var chosen : Bool
}

struct ContentView: View {
    
    @State var EditPressed = false
    @State var SearchText : String = ""
    @State var ListPressed = false
    @State var screenWidth = UIScreen.main.bounds.width
    @State var screenHeight = UIScreen.main.bounds.height
    @State var NewReminderPressed = false
    @State var title : String = ""
    @State var Notes : String = ""
    @State var isEditingTitle = false
    @State var isEditingNotes = false
    @State var DateToggle = false
    @State var TimeToggle = false
    @State var SelectedDate = Date()
    @State var SelectedTime = Date()
    @State var LocationToggle = false
    @State var AllPriority = [Priority(name: "None", chosen: false),
                              Priority(name: "Low", chosen: false),
                              Priority(name: "Medium", chosen: false),
                              Priority(name: "High", chosen: false)]
    @State var PriorityItemChosenIndex : Int = -1
    @State var SelectedList : String = ""
    @State var ListItemChosenIndex : Int = -1
    @State var ReminderList = [ReminderLists(name: "日々に疲れだ", chosen: false), ReminderLists(name: "Reminder", chosen: false)]
    @State var AddListPressed = false
    @State var LogoColor = (Color).blue
    @State var ListName : String = ""
    @State var isEditingListName = false
    @State var ListColors = [ColorPalette(color: .red, chosen: false), ColorPalette(color: .orange, chosen: false), ColorPalette(color: .yellow, chosen: false), ColorPalette(color: .green, chosen: false), ColorPalette(color: .blue, chosen: false), ColorPalette(color: .purple, chosen: false), ColorPalette(color: .brown, chosen: false)]
    @State var ListColorChosenIndex : Int = -1
    @State var ScheduleReminders = [Reminders(ItemName: "作业2选题", Chosen: false, Catagory: "Reminders"),
                                 Reminders(ItemName: "孝饼数学复习", Chosen: false, Catagory: "Reminders"),
                                 Reminders(ItemName: "运动", Chosen: false, Catagory: "Reminders"),
                                 Reminders(ItemName: "停谷", Chosen: false, Catagory: "Reminders")]
    @State var ConfirmationCheck = false
    @State var ConfirmationListCheck = false
    @State var LocationChosenIndex = 1
//    @State var NewReminderPressed = false
    
    
    var body: some View {
        NavigationView{
                ZStack{
                    Color.init(red: 241/256, green: 242/256, blue:246/256).ignoresSafeArea()
                    VStack{
                        Edit.frame(width: screenWidth/1.1, alignment: .topTrailing)
                        Section(){
                            Search.frame(alignment: .top)
                            TodayAndScheduled
                            All
                        }
                        MyLists
                        Bottom
                    }.frame(width: screenWidth/1.1)
                }.frame(height: screenHeight/1.1).navigationBarItems(trailing: EditButton())
        }
    }
    var Edit : some View{
        Button("Edit", action: {
            EditPressed.toggle()
        }).foregroundColor(EditPressed ? .green : .blue)
    }
    
    var Search : some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color(red: 225/256, green: 221/256, blue: 220/256)).frame(width: screenWidth/1.1, height: 40)
            HStack{
                Text(" ")
                Image(systemName: "magnifyingglass").foregroundColor(.gray).font(.system(size: 20))
                TextField(text: $SearchText){
                    Text("Search")
                }
            }
        }
        
    }
    
    var TodayAndScheduled : some View{
        HStack{
            Today
            Spacer()
            Scheduled
        }.frame(height: 120)
    }
    
    var Today : some View{
        NavigationLink(destination: TodayView()){
                ZStack{
                    RoundedRectangle(cornerRadius: 10).frame(width: 180, height: 100).foregroundColor(.white)
                    VStack{
                        HStack{
                            Image(systemName: "calendar.circle.fill").foregroundColor(.blue).font(.system(size: 40)).frame(height: 55,alignment: .topLeading)
                            Text("0").font(.system(size: 30)).bold().frame(width: 90, height: 50,alignment: .topTrailing).foregroundColor(.black)
                        }.frame(width: 160, height: 50, alignment: .topLeading)
                        Text("Today").font(.system(size: 18)).bold().foregroundColor(.gray).frame(width: 150, height: 20, alignment: .leading)
                    }
                }
            }.frame(height: 100)
            
    }
    
    var Scheduled : some View{
        NavigationLink(destination: ScheduledView()){
               ZStack{
                   RoundedRectangle(cornerRadius: 10).frame(width: 180, height: 100).foregroundColor(.white)
                   VStack{
                       HStack{
                           Image(systemName: "calendar.circle.fill").foregroundColor(.red).font(.system(size: 40)).frame(height: 55,alignment: .topLeading)
                           Text("1").font(.system(size: 30)).bold().frame(width: 90, height: 50,alignment: .topTrailing).foregroundColor(.black)
                       }.frame(width: 160, height: 50, alignment: .topLeading)
                       Text("Scheduled").font(.system(size: 18)).bold().foregroundColor(.gray).frame(width: 150, height: 20, alignment: .leading)
                   }
               }.navigationBarHidden(true)
            }.frame(height: 100)
    }
    
    var All : some View{
            ZStack{
                NavigationLink(destination: AllView()){
                    RoundedRectangle(cornerRadius: 10).frame(width: 400, height: 100).foregroundColor(.white)
                }.navigationBarHidden(true)
                VStack{
                    HStack{
                        Image(systemName: "tray.circle.fill").foregroundColor(Color(red: 92/256, green: 98/256, blue: 105/256)).font(.system(size: 40)).frame(height: 55,alignment: .topLeading)
                        Text("1").font(.system(size: 30)).bold().frame(width: 290, height: 50,alignment: .topTrailing).foregroundColor(.black)
                        }.frame(width: 360, height: 50, alignment: .topLeading)
                        Text("All").font(.system(size: 18)).bold().foregroundColor(.gray).frame(width: 340, height: 20, alignment: .leading)
                    }
                }.mask(RoundedRectangle(cornerRadius: 10).frame(width: 380, height: 100, alignment: .topLeading)).frame(height: 100)
        
    }
    
    var MyLists : some View{
        List{
            Section(header: Text("My Lists").font(.system(size: 30).bold())){
                NavigationLink(destination: pageone){
                    HStack{
                        Image(systemName: "list.bullet.circle.fill").font(.system(size: 30)).foregroundColor(.blue)
                        Text("Reminder")
                    }
                }
                NavigationLink(destination: pagetwo){
                    HStack{
                        Image(systemName: "list.bullet.circle.fill").font(.system(size: 30)).foregroundColor(.blue)
                        Text("日々に疲れだ")
                    }
                }
            }
        }.frame(width: screenWidth).navigationBarHidden(true)
    }
    
    var Bottom : some View{
        HStack{
            HStack{
                Image(systemName: "plus.circle.fill").foregroundColor(.blue)
                Text("New Reminder").foregroundColor(.blue)
            }.frame(width: screenWidth/1.35, alignment: .leading).font(.system(size: 17).bold()).onTapGesture {
                withAnimation(.easeIn(duration: 2000.0))
                {
                    NewReminderPressed.toggle()
                }
                }.sheet(isPresented: $NewReminderPressed){
                    NewReminderSheet
                }
            Text("Add List").foregroundColor(.blue).onTapGesture {
                withAnimation(.spring())
                {
                    AddListPressed.toggle()
                }
            }.sheet(isPresented: $AddListPressed){AddListSheet}
        }.frame(width: screenWidth)
    }
    
    var NewReminderSheet : some View{
        NavigationView{
            ZStack{
                Color.init(red: 242/256, green: 242/256, blue:247/256).ignoresSafeArea()
                VStack{
                    List{
                        TextField("Title", text: $title, onEditingChanged: {
                            isEditingTitle in self.isEditingTitle = isEditingTitle
                        })
                        TextField("Notes", text: $Notes, onEditingChanged: {
                            isEditingNotes in self.isEditingNotes = isEditingNotes
                        }).frame(height: 100, alignment: .top)
                    }
                    List{
                        NavigationLink(destination:
                            withAnimation(.spring()){
                                DetailsView
                        }){
                            Text("Details")
                        }
                    }.position(x: screenWidth/2, y: 40)
                    List{
                        NavigationLink(destination:
                            withAnimation(.easeIn){
                                ListView
                        }){
                            Text("List")
                        }
                    }.position(x: screenWidth/2, y: -150)
                }.navigationBarTitle("Details", displayMode: .inline).navigationBarItems(leading: CancelButton, trailing: AddButton)
            }
        }
    }
    
    var CancelButton : some View{
        Button("Cancel",action: {
            ConfirmationCheck.toggle()
        }).confirmationDialog(" ", isPresented: $ConfirmationCheck) {
            Button("Discard Changes") { NewReminderPressed.toggle() }
            Button("Cancel", role: .cancel) { }
        }
    }
    
    var AddButton : some View{
        Button("Add", action: {
            NewReminderPressed.toggle()
        })
    }
    
    var DetailsView : some View{
//        NavigationView{
            ZStack{
                Color.init(red: 242/256, green: 242/256, blue:247/256).ignoresSafeArea()
                Form{
                    Section{
                        HStack{
                            Image(systemName: "calendar.circle.fill").foregroundColor(.red).font(.system(size: 35))
                            Toggle("Date",isOn: $DateToggle)
                        }
                        if(DateToggle)
                        {
                            HStack{DatePicker("Today", selection: $SelectedDate, displayedComponents: [.date]).datePickerStyle(.graphical)}
                        }
                        HStack{
                            Image(systemName: "clock.fill").foregroundColor(.blue).font(.system(size: 35))
                            Toggle("Time",isOn: $TimeToggle)
                        }
                        if(TimeToggle)
                        {
                            DatePicker("Now", selection: $SelectedTime,displayedComponents: [.hourAndMinute]).datePickerStyle(.compact).frame(width:screenWidth/1.2, alignment: .center)
                        }
                    }
                    Section{
                        VStack{
                            HStack{
                                Image(systemName: "location.circle.fill").foregroundColor(.blue).font(.system(size: 35))
                                Toggle("Location",isOn: $LocationToggle)
                            }
                            if(LocationToggle)
                            {
                                HStack{
                                    VStack{
                                        ZStack{
                                            Circle().foregroundColor(LocationChosenIndex == 1 ? .blue : .gray).frame(width: 50, height: 50)
                                            Image(systemName: "location.circle.fill").symbolRenderingMode(.palette).foregroundStyle(.white, LocationChosenIndex == 1 ? .blue : .gray).font(.system(size: 35))
                                        }.onTapGesture {
                                            LocationChosenIndex = 1
                                        }
                                        if(LocationChosenIndex != 1)
                                        {
                                            Text("Current").font(.system(size: 13)).frame(width: 70, height: 30)
                                        }
                                        else{
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 10).foregroundColor(.blue).frame(width: 75, height: 25)
                                                Text("Current").font(.system(size: 13)).foregroundColor(.white).frame(width: 70, height: 30)
                                            }
                                        }
                                    }.frame(width: 80, height: 80)
                                    VStack{
                                        ZStack{
                                            Circle().foregroundColor(LocationChosenIndex == 2 ? .blue : .gray).frame(width: 50, height: 50)
                                            Image(systemName: "car.circle.fill").symbolRenderingMode(.palette).foregroundStyle(.white, LocationChosenIndex == 2 ? .blue : .gray).font(.system(size: 35))
                                        }.onTapGesture {
                                            LocationChosenIndex = 2
                                        }
                                        if(LocationChosenIndex != 2)
                                        {
                                            Text("Getting In").font(.system(size: 13)).frame(width: 70, height: 30)
                                        }
                                        else{
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 10).foregroundColor(.blue).frame(width: 75, height: 25)
                                                Text("Getting In").font(.system(size: 13)).foregroundColor(.white).frame(width: 70, height: 30)
                                            }
                                        }
                                    }.frame(width: 80, height: 80)
                                    VStack{
                                        ZStack{
                                            Circle().foregroundColor(LocationChosenIndex == 3 ? .blue : .gray).frame(width: 50, height: 50)
                                            Image(systemName: "car.circle.fill").symbolRenderingMode(.palette).foregroundStyle(.white, LocationChosenIndex == 3 ? .blue : .gray).font(.system(size: 35))
                                        }.onTapGesture {
                                            LocationChosenIndex = 3
                                        }
                                        if(LocationChosenIndex != 3)
                                        {
                                            Text("Getting Out").font(.system(size: 13)).frame(width: 80, height: 30)
                                        }
                                        else{
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 10).foregroundColor(.blue).frame(width: 80, height: 25)
                                                Text("Getting Out").font(.system(size: 13)).foregroundColor(.white).frame(width: 80, height: 30)
                                            }
                                        }
                                    }.frame(width: 80, height: 80)
                                    NavigationLink(destination: CustomLinkPage)
                                    {
                                        VStack{
                                            ZStack{
                                                Circle().foregroundColor(LocationChosenIndex == 4 ? .blue : .gray).frame(width: 50, height: 50)
                                                Image(systemName: "ellipsis.circle.fill").symbolRenderingMode(.palette).foregroundStyle(.white, LocationChosenIndex == 4 ? .blue : .gray).font(.system(size: 35))
                                            }.onTapGesture {
                                                LocationChosenIndex = 4
                                            }
                                            if(LocationChosenIndex != 4)
                                            {
                                                Text("Custom").font(.system(size: 13)).frame(width: 70, height: 30)
                                            }
                                            else{
                                                ZStack{
                                                    RoundedRectangle(cornerRadius: 10).foregroundColor(.blue).frame(width: 80, height: 25)
                                                    Text("Custom").font(.system(size: 13)).foregroundColor(.white).frame(width: 70, height: 30)
                                                }
                                            }
                                        }.frame(width: 80, height: 80)
                                    }
                                }
                                Divider()
                                if(LocationChosenIndex == 1)
                                {
                                    Text("Arriving: China Zhejiang Hangzhou Xihu No.38, Zheda Road Zhejiang University Yuquan Campus").frame(width: screenWidth/1.3, alignment: .topLeading).foregroundColor(.gray)
                                }
                                else if(LocationChosenIndex == 2)
                                {
                                    Text("Getting in the car").frame(width: screenWidth/1.3, alignment: .topLeading).foregroundColor(.gray)
                                }
                                else if(LocationChosenIndex == 3)
                                {
                                    Text("Getting out of the car").frame(width: screenWidth/1.3, alignment: .topLeading).foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    Section{
                        NavigationLink(destination: PriorityView){
                            Text("Priority")
                        }.ignoresSafeArea()
                        
                    }
                }.offset(y: -30)
            }
//        }
    }
    
    @State var CustomLinkChosenIndex = 1
    
    var CustomLinkPage : some View{
        VStack{
            Search.frame(width: screenWidth/1.1)
            Form{
                HStack{
                    Image(systemName: "location.circle.fill").font(.system(size: 40)).foregroundColor(.gray)
                    VStack{
                        Text("Current location").frame(width: 250, alignment: .topLeading)
                        Text("Locating...").foregroundColor(.gray).font(.system(size: 10)).frame(width: 250, alignment: .topLeading)
                    }
                    if(CustomLinkChosenIndex == 1)
                    {
                        Image(systemName: "checkmark").foregroundColor(.blue).font(.system(size: 20))
                    }
                }.onTapGesture {
                    CustomLinkChosenIndex = 1
                }
                HStack{
                    Image(systemName: "car.circle.fill").font(.system(size: 40)).foregroundColor(.blue)
                    VStack{
                        Text("Getting in the car").frame(width: 250, alignment: .topLeading)
                        Text("When connecting to any paired car").foregroundColor(.gray).font(.system(size: 10)).frame(width: 250, alignment: .topLeading)
                    }
                    if(CustomLinkChosenIndex == 2)
                    {
                        Image(systemName: "checkmark").foregroundColor(.blue).font(.system(size: 20))
                    }
                }
                    .onTapGesture {
                    CustomLinkChosenIndex = 2
                }
                HStack{
                    Image(systemName: "car.circle.fill").font(.system(size: 40)).foregroundColor(.blue)
                    VStack{
                        Text("Getting out of the car").frame(width: 250, alignment: .topLeading)
                        Text("When disconnecting from any paired car").foregroundColor(.gray).font(.system(size: 10)).frame(width: 250, alignment: .topLeading)
                    }.frame(width: 250)
                    if(CustomLinkChosenIndex == 3)
                    {
                        Image(systemName: "checkmark").foregroundColor(.blue).font(.system(size: 20))
                    }
                }.onTapGesture {
                    CustomLinkChosenIndex = 3
                }
            }
        }.navigationBarTitle("Location")
    }
    
    var PriorityView: some View{
        ZStack{
            Color.init(red: 242/256, green: 242/256, blue:247/256).ignoresSafeArea()
            List{
                ForEach(AllPriority.indices){index in
                    HStack{
                        Text(AllPriority[index].name).frame(width: 300, alignment: .leading).onTapGesture {
                            PriorityItemChosenIndex = index
                        }
                        if(index == PriorityItemChosenIndex)
                        {
                            Image(systemName: "checkmark").foregroundColor(.blue)
                        }
                    }
                }
            }
        }
    }
    
    var ListView: some View{
        VStack(spacing: -20){
            Text("Reminders will be moved to list \(SelectedList)").font(.system(size: 15).bold())
            List{
                ForEach(ReminderList.indices){index in
                    HStack{
                        Image(systemName: "list.bullet.circle.fill").font(.system(size: 30)).foregroundColor(.orange)
                        Text(ReminderList[index].name).frame(width: 250, alignment: .leading).onTapGesture {
                            ListItemChosenIndex = index
                            SelectedList = ReminderList[index].name
                        }
                        if(index == ListItemChosenIndex)
                        {
                            Image(systemName: "checkmark").foregroundColor(.blue)
                        }
                    }
                }
            }.navigationBarTitle("List")
        }
    }
    
    var AddListSheet : some View{
        NavigationView{
            ZStack{
                Color.init(red: 242/256, green: 242/256, blue:247/256).ignoresSafeArea()
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10).foregroundColor(.white).frame(width: screenWidth/1.1, height: 200).position(x: screenWidth/2, y: 115)
                        VStack{
                            Image(systemName: "list.bullet.circle.fill").shadow(radius: 5).font(.system(size: 100)).frame(width: screenWidth/1.1, height: 100, alignment: .center).position(x: screenWidth/2, y: 80).symbolRenderingMode(.palette).foregroundStyle(.white, LogoColor)
                            TextField("List Name", text: $ListName, onEditingChanged: {
                                isEditingListName in self.isEditingListName = isEditingListName
                            }).frame(width: screenWidth/1.2, height:30, alignment: .center).position(x: screenWidth/2, y: -20).multilineTextAlignment(.center).textFieldStyle(.roundedBorder).font(.system(size: 40))
                        }
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 10).foregroundColor(.white).frame(width: screenWidth/1.1, height: 70).position(x: screenWidth/2, y: -115)
                        HStack{
                            ForEach(ListColors.indices){index in
                                Circle().font(.system(size: 20)).foregroundColor(ListColors[index].color).scaleEffect(0.9).onTapGesture {
                                    ListItemChosenIndex = index
                                    LogoColor = ListColors[index].color
                                }
                            }
                        }.frame(width: screenWidth/1.2).position(x: screenWidth/2, y: -115)
                    }
                }
            }.navigationBarTitle("New List", displayMode: .inline).navigationBarItems(leading: CancelListButton, trailing: DoneListButton)
        }
    }
    
    var CancelListButton : some View{
        Button("Cancel", action: {
            ConfirmationListCheck.toggle()
        }).confirmationDialog(" ", isPresented: $ConfirmationListCheck) {
            Button("Discard Changes") { AddListPressed.toggle() }
            Button("Cancel", role: .cancel) { }
        }
    }
    
    var DoneListButton : some View{
        Button("Done", action: {
            AddListPressed.toggle()
        })
    }
    
    var pageone : some View{
        NavigationView{
            ZStack{
                VStack{
                    List(){
                        Section(header: Text("Reminders").font(.system(size: 30)).foregroundColor(.blue).fontWeight(.bold).frame(width: screenWidth/2.3)){
                                ForEach(ScheduleReminders.indices) { index in
                                    HStack{
                                        if(ScheduleReminders[index].Chosen == false)
                                        {
                                            Image(systemName: "circle").font(.system(size: 25)).foregroundColor(Color(red: 193/256, green: 193/256, blue: 195/256)).onTapGesture {
                                                ScheduleReminders[index].Chosen.toggle()
                                                
                                            }
                                        }
                                        else{
                                            Image(systemName: "circle.inset.filled").font(.system(size: 25)).foregroundColor(.blue).onTapGesture {
                                                ScheduleReminders[index].Chosen
                                                    .toggle()
                                            }
                                        }
                                        VStack(alignment: .leading){
                                            Text(ScheduleReminders[index].ItemName).foregroundColor(ScheduleReminders[index].Chosen ? .gray : .black)
                                            Text(ScheduleReminders[index].Catagory).foregroundColor(.gray).font(.system(size: 15))
                                        }
                                    }
                                }.onDelete(perform: ScheduledView().delete)
                        }
                    }
                    Spacer()
                    HStack{
                        Image(systemName: "plus.circle.fill").foregroundColor(.blue)
                        Text("New Reminder").foregroundColor(.blue)
                    }.frame(width: screenWidth/1.35, alignment: .leading).font(.system(size: 17).bold()).onTapGesture {
                            NewReminderPressed.toggle()
                        }.sheet(isPresented: $NewReminderPressed){
                           NewReminderSheet
                    }
                }.frame(height: screenHeight)
            }.frame(width: screenWidth/0.9, height: screenHeight/1.1)
        }
    }
    var pagetwo : some View{
        NavigationView{
            ZStack{
                VStack{
                    List(){
                        Section(header: Text("日々に疲れだ").font(.system(size: 30)).foregroundColor(.blue).fontWeight(.bold).position(x: 105)){
                                ForEach(ScheduleReminders.indices) { index in
                                    HStack{
                                        if(ScheduleReminders[index].Chosen == false)
                                        {
                                            Image(systemName: "circle").font(.system(size: 25)).foregroundColor(Color(red: 193/256, green: 193/256, blue: 195/256)).onTapGesture {
                                                ScheduleReminders[index].Chosen.toggle()
                                                
                                            }
                                        }
                                        else{
                                            Image(systemName: "circle.inset.filled").font(.system(size: 25)).foregroundColor(.blue).onTapGesture {
                                                ScheduleReminders[index].Chosen
                                                    .toggle()
                                            }
                                        }
                                        VStack(alignment: .leading){
                                            Text(ScheduleReminders[index].ItemName).foregroundColor(ScheduleReminders[index].Chosen ? .gray : .black)
                                            Text(ScheduleReminders[index].Catagory).foregroundColor(.gray).font(.system(size: 15))
                                        }
                                    }
                                }.onDelete(perform: ScheduledView().delete)
                        }
                    }
                    Spacer()
                    HStack{
                        Image(systemName: "plus.circle.fill").foregroundColor(.blue)
                        Text("New Reminder").foregroundColor(.blue)
                    }.frame(width: screenWidth/1.35, alignment: .leading).font(.system(size: 17).bold()).onTapGesture {
                            NewReminderPressed.toggle()
                        }.sheet(isPresented: $NewReminderPressed){
                           NewReminderSheet
                    }
                }.frame(height: screenHeight)
            }.frame(width: screenWidth/0.9, height: screenHeight/1.1)
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TodayView : View{
    
    @State var screenWidth = UIScreen.main.bounds.width
    @State var screenHeight = UIScreen.main.bounds.height
    @State var TodayReminders = [Reminders(ItemName: "作业2选题", Chosen: false, Catagory: "Reminders"),
                                 Reminders(ItemName: "孝饼数学复习", Chosen: false, Catagory: "Reminders"),
                                 Reminders(ItemName: "运动", Chosen: false, Catagory: "Reminders"),
                                 Reminders(ItemName: "停谷", Chosen: false, Catagory: "Reminders")]
    @State var NewReminderPressed = false
    
    init(){
           UITableView.appearance().backgroundColor = .clear
           UITableViewCell.appearance().backgroundColor = .clear
           //若不要row分隔线的话：
        //UITableView.appearance().separatorStyle = .singleLine
    }
    
    var body: some View{
        NavigationView{
            ZStack{
                VStack{
                    List{
                        Section(header: Text("Today").font(.system(size: 30)).foregroundColor(.blue).fontWeight(.bold)){
                            ForEach(TodayReminders.indices) { index in
                                HStack{
                                    if(TodayReminders[index].Chosen == false)
                                    {
                                        Image(systemName: "circle").font(.system(size: 25)).foregroundColor(Color(red: 193/256, green: 193/256, blue: 195/256)).onTapGesture {
                                            TodayReminders[index].Chosen.toggle()
                                            
                                        }
                                    }
                                    else{
                                        Image(systemName: "circle.inset.filled").font(.system(size: 25)).foregroundColor(.blue).onTapGesture {
                                            TodayReminders[index].Chosen
                                                .toggle()
                                        }
                                    }
                                    VStack(alignment: .leading){
                                        Text(TodayReminders[index].ItemName).foregroundColor(TodayReminders[index].Chosen ? .gray : .black)
                                        Text(TodayReminders[index].Catagory).foregroundColor(.gray).font(.system(size: 15))
                                    }
                                }
                            }.onDelete(perform: delete)
                            
                        }
                    }
                }.frame(height: screenHeight)
                
            }.frame(width: screenWidth/0.95)
        }
    }
    
    func delete(at offsets: IndexSet)
    {
        TodayReminders.remove(atOffsets: offsets)
    }
    
    
}

struct ScheduledView : View{
    
    @State var screenWidth = UIScreen.main.bounds.width
    @State var screenHeight = UIScreen.main.bounds.height
    @State var ScheduleReminders = [Reminders(ItemName: "作业2选题", Chosen: false, Catagory: "Reminders"),
                                 Reminders(ItemName: "孝饼数学复习", Chosen: false, Catagory: "Reminders"),
                                 Reminders(ItemName: "运动", Chosen: false, Catagory: "Reminders"),
                                 Reminders(ItemName: "停谷", Chosen: false, Catagory: "Reminders")]
    @State var NewReminderPressed = false
    
    init(){
           UITableView.appearance().backgroundColor = .clear
           UITableViewCell.appearance().backgroundColor = .clear
           //若不要row分隔线的话：
        //UITableView.appearance().separatorStyle = .singleLine
    }
    
    var body: some View{
        NavigationView{
            ZStack{
                VStack{
                    List(){
                        Section(header: Text("Scheduled").font(.system(size: 30)).foregroundColor(.red).fontWeight(.bold).frame(width: screenWidth/2.3)){
                            Section(header: Text("Today").frame(width: screenWidth/5.8  )){
                                ForEach(ScheduleReminders.indices) { index in
                                    HStack{
                                        if(ScheduleReminders[index].Chosen == false)
                                        {
                                            Image(systemName: "circle").font(.system(size: 25)).foregroundColor(Color(red: 193/256, green: 193/256, blue: 195/256)).onTapGesture {
                                                ScheduleReminders[index].Chosen.toggle()
                                                
                                            }
                                        }
                                        else{
                                            Image(systemName: "circle.inset.filled").font(.system(size: 25)).foregroundColor(.blue).onTapGesture {
                                                ScheduleReminders[index].Chosen
                                                    .toggle()
                                            }
                                        }
                                        VStack(alignment: .leading){
                                            Text(ScheduleReminders[index].ItemName).foregroundColor(ScheduleReminders[index].Chosen ? .gray : .black)
                                            Text(ScheduleReminders[index].Catagory).foregroundColor(.gray).font(.system(size: 15))
                                        }
                                    }
                                }.onDelete(perform: delete)
                            }
                        }
                    }
                }.frame(height: screenHeight)
            }.frame(width: screenWidth/0.9, height: screenHeight/1.1)
        }
    }
    
    func delete(at offsets: IndexSet)
    {
        ScheduleReminders.remove(atOffsets: offsets)
    }
    
}


struct AllView : View{
    
    @State var screenWidth = UIScreen.main.bounds.width
    @State var screenHeight = UIScreen.main.bounds.height
    @State var AllReminders = [Reminders(ItemName: "作业2选题", Chosen: false, Catagory: "Reminders"),
                                 Reminders(ItemName: "孝饼数学复习", Chosen: false, Catagory: "Reminders"),
                                 Reminders(ItemName: "运动", Chosen: false, Catagory: "Reminders"),
                                 Reminders(ItemName: "停谷", Chosen: false, Catagory: "Reminders")]
    @State var AllPriority = [Priority(name: "None", chosen: false),
                              Priority(name: "Low", chosen: false),
                              Priority(name: "Medium", chosen: false),
                              Priority(name: "High", chosen: false)]
    @State var ReminderList = [ReminderLists(name: "日々に疲れだ", chosen: false), ReminderLists(name: "Reminder", chosen: false)]
    @State var NewReminderPressed = false
    @State var NewReminder: String = ""
    @State var isEditing = false
    @State var ShowInfo = false
    @State var ShowInfoSheet = false
    @State var isEditingReminder = false
    @State var isEditingNotes = false
    @State var isEditingURL = false
    @State var ReminderName : String = "New Reminder"
    @State var Notes : String = ""
    @State var URLInput : String = ""
    @State var DateToggle = false
    @State var SelectedDate = Date()
    @State var TimeToggle = false
    @State var SelectedTime = Date()
    @State var LocationToggle = false
    @State var PriorityItemChosenIndex : Int = -1
    @State var SelectedList : String = ""
    @State var ListItemChosenIndex : Int = -1
    @State var LocationChosenIndex = 1
    @State var ConfirmationListCheck = false
    @State var CustomLinkChosenIndex = 1
    
    init(){
           UITableView.appearance().backgroundColor = .clear
           UITableViewCell.appearance().backgroundColor = .clear
           //若不要row分隔线的话：
        //UITableView.appearance().separatorStyle = .singleLine
    }
    
    var body: some View{
        NavigationView{
            ZStack{
                VStack{
                    List(){
                        Section(header: Text("  All").font(.system(size: 30)).foregroundColor(Color(red: 92/256, green: 98/256, blue: 105/256)).fontWeight(.bold)){
                            Section(header: Text(" Reminders").foregroundColor(.blue)){
                                ForEach(AllReminders.indices) { index in
                                    HStack{
                                        if(AllReminders[index].Chosen == false)
                                        {
                                            Image(systemName: "circle").font(.system(size: 25)).foregroundColor(Color(red: 193/256, green: 193/256, blue: 195/256)).onTapGesture {
                                                AllReminders[index].Chosen.toggle()
                                                
                                            }
                                        }
                                        else{
                                            Image(systemName: "circle.inset.filled").font(.system(size: 25)).foregroundColor(.blue).onTapGesture {
                                                AllReminders[index].Chosen
                                                    .toggle()
                                            }
                                        }
                                        VStack(alignment: .leading){
                                            Text(AllReminders[index].ItemName).foregroundColor(AllReminders[index].Chosen ? .gray : .black)
                                            Text(AllReminders[index].Catagory).foregroundColor(.gray).font(.system(size: 15))
                                        }
                                    }
                                }.onDelete(perform: delete)
                            }
                            HStack{
                                Image(systemName: "plus.circle.fill").font(.system(size: 25)).foregroundColor(Color(red: 193/256, green: 193/256, blue: 195/256))
                                TextField("", text:$NewReminder, onEditingChanged: {
                                    isEditing in self.isEditing = isEditing
                                    ShowInfo = true
                                })
                                if(ShowInfo == true)
                                {
                                    Image(systemName: "info.circle").foregroundColor(.blue).font(.system(size: 20)).frame(width: 50).onTapGesture{
                                        ShowInfoSheet.toggle()
                                    }.sheet(isPresented: $ShowInfoSheet){
                                        InfoSheet
                                    }
                                }
                            }
                        }
                    }.frame(height: screenHeight)
                }.frame(width: screenWidth/0.9, height: screenHeight/1.1)
            }
        }
    }
    
    var InfoSheet : some View{
        NavigationView{
            ZStack{
                Color.init(red: 242/256, green: 242/256, blue:247/256).ignoresSafeArea()
                Form{
                    Section{
                        TextField("New Reminder", text: $ReminderName, onEditingChanged: {
                            isEditingReminder in self.isEditingReminder = isEditingReminder
                        }).frame(height: 35)
                        Divider()
                        TextField("Notes", text: $Notes, onEditingChanged: {
                            isEditingNotes in self.isEditingNotes = isEditingNotes
                        }).frame(height: 35)
                        Divider()
                        TextField("URL", text: $URLInput, onEditingChanged: {
                            isEditingURL in self.isEditingURL = isEditingURL
                        }).frame(height: 35)
                    }.navigationBarTitle("Details", displayMode: .inline).navigationBarItems(leading: CancelButton, trailing: DoneButton)
                    Section{
                        HStack{
                            Image(systemName: "calendar.circle.fill").foregroundColor(.red).font(.system(size: 30))
                            Toggle("Date",isOn: $DateToggle)
                        }
                        if(DateToggle)
                        {
                            DatePicker("Today", selection: $SelectedDate, displayedComponents: [.date]).datePickerStyle(.graphical)
                        }
                        
                        HStack{
                            Image(systemName: "clock.fill").foregroundColor(.blue).font(.system(size: 30))
                            Toggle("Time",isOn: $TimeToggle)
                        }
                        if(TimeToggle)
                        {
                            DatePicker("Now", selection: $SelectedTime,displayedComponents: [.hourAndMinute]).datePickerStyle(.compact).frame(width:screenWidth/1.2, alignment: .center)
                        }
                    }
                    Section{
                        VStack{
                            HStack{
                                Image(systemName: "location.circle.fill").foregroundColor(.blue).font(.system(size: 35))
                                Toggle("Location",isOn: $LocationToggle)
                            }
                            if(LocationToggle)
                            {
                                HStack{
                                    VStack{
                                        ZStack{
                                            Circle().foregroundColor(LocationChosenIndex == 1 ? .blue : .gray).frame(width: 50, height: 50)
                                            Image(systemName: "location.circle.fill").symbolRenderingMode(.palette).foregroundStyle(.white, LocationChosenIndex == 1 ? .blue : .gray).font(.system(size: 35))
                                        }.onTapGesture {
                                            LocationChosenIndex = 1
                                        }
                                        if(LocationChosenIndex != 1)
                                        {
                                            Text("Current").font(.system(size: 13)).frame(width: 70, height: 30)
                                        }
                                        else{
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 10).foregroundColor(.blue).frame(width: 75, height: 25)
                                                Text("Current").font(.system(size: 13)).foregroundColor(.white).frame(width: 70, height: 30)
                                            }
                                        }
                                    }.frame(width: 80, height: 80)
                                    VStack{
                                        ZStack{
                                            Circle().foregroundColor(LocationChosenIndex == 2 ? .blue : .gray).frame(width: 50, height: 50)
                                            Image(systemName: "car.circle.fill").symbolRenderingMode(.palette).foregroundStyle(.white, LocationChosenIndex == 2 ? .blue : .gray).font(.system(size: 35))
                                        }.onTapGesture {
                                            LocationChosenIndex = 2
                                        }
                                        if(LocationChosenIndex != 2)
                                        {
                                            Text("Getting In").font(.system(size: 13)).frame(width: 70, height: 30)
                                        }
                                        else{
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 10).foregroundColor(.blue).frame(width: 75, height: 25)
                                                Text("Getting In").font(.system(size: 13)).foregroundColor(.white).frame(width: 70, height: 30)
                                            }
                                        }
                                    }.frame(width: 80, height: 80)
                                    VStack{
                                        ZStack{
                                            Circle().foregroundColor(LocationChosenIndex == 3 ? .blue : .gray).frame(width: 50, height: 50)
                                            Image(systemName: "car.circle.fill").symbolRenderingMode(.palette).foregroundStyle(.white, LocationChosenIndex == 3 ? .blue : .gray).font(.system(size: 35))
                                        }.onTapGesture {
                                            LocationChosenIndex = 3
                                        }
                                        if(LocationChosenIndex != 3)
                                        {
                                            Text("Getting Out").font(.system(size: 13)).frame(width: 80, height: 30)
                                        }
                                        else{
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 10).foregroundColor(.blue).frame(width: 80, height: 25)
                                                Text("Getting Out").font(.system(size: 13)).foregroundColor(.white).frame(width: 80, height: 30)
                                            }
                                        }
                                    }.frame(width: 80, height: 80)
                                    NavigationLink(destination: ContentView().CustomLinkPage)
                                    {
                                        VStack{
                                            ZStack{
                                                Circle().foregroundColor(LocationChosenIndex == 4 ? .blue : .gray).frame(width: 50, height: 50)
                                                Image(systemName: "ellipsis.circle.fill").symbolRenderingMode(.palette).foregroundStyle(.white, LocationChosenIndex == 4 ? .blue : .gray).font(.system(size: 35))
                                            }.onTapGesture {
                                                LocationChosenIndex = 4
                                            }
                                            if(LocationChosenIndex != 4)
                                            {
                                                Text("Custom").font(.system(size: 13)).frame(width: 70, height: 30)
                                            }
                                            else{
                                                ZStack{
                                                    RoundedRectangle(cornerRadius: 10).foregroundColor(.blue).frame(width: 80, height: 25)
                                                    Text("Custom").font(.system(size: 13)).foregroundColor(.white).frame(width: 70, height: 30)
                                                }
                                            }
                                        }.frame(width: 80, height: 80)
                                    }
                                }
                                Divider()
                                if(LocationChosenIndex == 1)
                                {
                                    Text("Arriving: China Zhejiang Hangzhou Xihu No.38, Zheda Road Zhejiang University Yuquan Campus").frame(width: screenWidth/1.3, alignment: .topLeading).foregroundColor(.gray)
                                }
                                else if(LocationChosenIndex == 2)
                                {
                                    Text("Getting in the car").frame(width: screenWidth/1.3, alignment: .topLeading).foregroundColor(.gray)
                                }
                                else if(LocationChosenIndex == 3)
                                {
                                    Text("Getting out of the car").frame(width: screenWidth/1.3, alignment: .topLeading).foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    Section{
                        NavigationLink(destination: PriorityView){
                            Text("Priority")
                        }
                        NavigationLink(destination: ListView){
                            Text("List")
                        }
                    }
                }
            }
        }
    }
    
    var CustomLinkPage : some View{
        VStack{
            ContentView().Search.frame(width: screenWidth/1.1)
            Form{
                HStack{
                    Image(systemName: "location.circle.fill").font(.system(size: 40)).foregroundColor(.gray)
                    VStack{
                        Text("Current location").frame(width: 250, alignment: .topLeading)
                        Text("Locating...").foregroundColor(.gray).font(.system(size: 10)).frame(width: 250, alignment: .topLeading)
                    }
                    if(CustomLinkChosenIndex == 1)
                    {
                        Image(systemName: "checkmark").foregroundColor(.blue).font(.system(size: 20))
                    }
                }.onTapGesture {
                    CustomLinkChosenIndex = 1
                }
                HStack{
                    Image(systemName: "car.circle.fill").font(.system(size: 40)).foregroundColor(.blue)
                    VStack{
                        Text("Getting in the car").frame(width: 250, alignment: .topLeading)
                        Text("When connecting to any paired car").foregroundColor(.gray).font(.system(size: 10)).frame(width: 250, alignment: .topLeading)
                    }
                    if(CustomLinkChosenIndex == 2)
                    {
                        Image(systemName: "checkmark").foregroundColor(.blue).font(.system(size: 20))
                    }
                }
                    .onTapGesture {
                    CustomLinkChosenIndex = 2
                }
                HStack{
                    Image(systemName: "car.circle.fill").font(.system(size: 40)).foregroundColor(.blue)
                    VStack{
                        Text("Getting out of the car").frame(width: 250, alignment: .topLeading)
                        Text("When disconnecting from any paired car").foregroundColor(.gray).font(.system(size: 10)).frame(width: 250, alignment: .topLeading)
                    }.frame(width: 250)
                    if(CustomLinkChosenIndex == 3)
                    {
                        Image(systemName: "checkmark").foregroundColor(.blue).font(.system(size: 20))
                    }
                }.onTapGesture {
                    CustomLinkChosenIndex = 3
                }
            }
        }.navigationBarTitle("Location")
    }
    
    var CancelButton : some View{
        Button("Cancel", action: {
            ConfirmationListCheck.toggle()
        }).confirmationDialog(" ", isPresented: $ConfirmationListCheck) {
            Button("Discard Changes") { ShowInfoSheet.toggle() }
            Button("Cancel", role: .cancel) { }
        }
    }
    
    var DoneButton: some View{
        Button("Done", action: {
            ShowInfoSheet.toggle()
        })
    }
    
    var PriorityView: some View{
        ZStack{
            Color.init(red: 242/256, green: 242/256, blue:247/256).ignoresSafeArea()
            List{
                ForEach(AllPriority.indices){index in
                    HStack{
                        Text(AllPriority[index].name).frame(width: 300, alignment: .leading).onTapGesture {
                            PriorityItemChosenIndex = index
                        }
                        if(index == PriorityItemChosenIndex)
                        {
                            Image(systemName: "checkmark").foregroundColor(.blue)
                        }
                    }
                }
            }
        }
    }
    
    var ListView: some View{
        VStack(spacing: -20){
            Text("Reminders will be moved to list \(SelectedList)").font(.system(size: 15).bold())
            List{
                ForEach(ReminderList.indices){index in
                    HStack{
                        Image(systemName: "list.bullet.circle.fill").font(.system(size: 30)).foregroundColor(.orange)
                        Text(ReminderList[index].name).frame(width: 250, alignment: .leading).onTapGesture {
                            ListItemChosenIndex = index
                            SelectedList = ReminderList[index].name
                        }
                        if(index == ListItemChosenIndex)
                        {
                            Image(systemName: "checkmark").foregroundColor(.blue)
                        }
                    }
                }
            }.navigationBarTitle("List")
        }
    }
    
    func delete(at offsets: IndexSet)
    {
        AllReminders.remove(atOffsets: offsets)
    }
    
}
