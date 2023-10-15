import RealmSwift

class TaskModel: Object {
    @Persisted var id: String
    @Persisted var title: String
    @Persisted var subTitle: String
    @Persisted var isReady: Bool
}
