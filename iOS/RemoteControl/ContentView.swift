//
//  ContentView.swift
//  RemoteControl
//
//  Created by ryunosuke.shibuya on 2023/04/23.
//

import SwiftUI
import Starscream

struct ContentView: View {
    @GestureState private var isDragging = false
    private let socket: WebSocket

    init() {
        let request = URLRequest(url: URL(string: "ws://192.168.0.33:8020")!)
        socket = WebSocket(request: request)
        socket.connect()
    }

    var body: some View {
        Color.white
            .gesture(
                DragGesture()
                    .updating($isDragging) { value, isDragging, _ in
                        defer { isDragging = true }
                        send(value.location, isDragging ? .touchMove : .touchDown)
                    }
                    .onEnded { value in
                        send(value.location, .touchUp)
                    }
            )
            .onTapGesture { location in
                send(location, .touch)
            }
    }

    func send(_ location: CGPoint, _ type: TouchType) {
        guard let data = "\(location.x),\(location.y),\(type.rawValue)".data(using: .utf8) else { return }
        socket.write(data: data, completion: nil)
    }
}

enum TouchType: Int {
    case touchDown, touchMove, touchUp, touch
}
