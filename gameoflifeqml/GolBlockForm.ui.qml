import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Rectangle {
    id: block
    width: 30
    height: 30
    state: "EMPTY"

    states: [
        State {
            name: "DEAD"
            PropertyChanges { target: block; color: "#ffffff"}
        },
        State {
            name: "EMPTY"
            PropertyChanges { target: block; color: "#eeeeee"}
        },
        State {
            name: "LIVE"
            PropertyChanges { target: block; color: "#000000"}
        },
        State {
            name: "NEWBORN"
            PropertyChanges { target: block; color: "#000000"}
        }
    ]
}
