
enum ErrorsEnum: Error, Equatable {
    case invalidUrl(_ :String)
    case noDataFound(_ :String)
    case errorObteiningData(_ :String)
    case errorObteiningLocation(_ :String)
    case userCanNotBeFound(_ :String)
}
