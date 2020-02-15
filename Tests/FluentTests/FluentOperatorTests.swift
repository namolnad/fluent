import Fluent
import Vapor
import XCTVapor

final class FluentOperatorTests: XCTestCase {
    func testCustomOperators() throws {
        let db = DummyDatabase()

        // name contains string anywhere, prefix, suffix
        _ = Planet.query(on: db)
            .filter(\.$name ~~ "art")
        _ = Planet.query(on: db)
            .filter(\.$name =~ "art")
        _ = Planet.query(on: db)
            .filter(\.$name ~= "art")
        // name doesn't contain string anywhere, prefix, suffix
        _ = Planet.query(on: db)
            .filter(\.$name !~ "art")
        _ = Planet.query(on: db)
            .filter(\.$name !=~ "art")
        _ = Planet.query(on: db)
            .filter(\.$name !~= "art")

        // name in array
        _ = Planet.query(on: db)
            .filter(\.$name ~~ ["Earth", "Mars"])
        // name not in array
        _ = Planet.query(on: db)
            .filter(\.$name !~ ["Earth", "Mars"])
    }
}
private final class Planet: Model {
    static let schema = "planets"

    @ID(key: "id")
    var id: Int?

    @Field(key: "name")
    var name: String
}

private struct DummyDatabase: Database {
    var context: DatabaseContext {
        fatalError()
    }

    func execute(query: DatabaseQuery, onRow: @escaping (DatabaseRow) -> ()) -> EventLoopFuture<Void> {
        fatalError()
    }

    func execute(schema: DatabaseSchema) -> EventLoopFuture<Void> {
        fatalError()
    }

    func withConnection<T>(_ closure: @escaping (Database) -> EventLoopFuture<T>) -> EventLoopFuture<T> {
        fatalError()
    }
}