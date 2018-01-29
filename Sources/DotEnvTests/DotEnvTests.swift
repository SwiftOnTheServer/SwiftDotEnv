import XCTest

@testable import DotEnv

class DotEnvTests: XCTestCase {

    var env: DotEnv!

    override func setUp() {
        let path = "\(FileManager.default.currentDirectoryPath)/mock.env"
        let mockEnv =
        """
        # example comment

        MOCK_STRING=helloMom
        MOCK_INT=42
        MOCK_BOOL=true
        """
        FileManager.default.createFile(atPath: path, contents: mockEnv.data(using: .utf8), attributes: nil)
        env = DotEnv(withFile: "mock.env")
    }

    func test_get_returnsString() {
        let actualResult = env.get("MOCK_STRING")
        
        XCTAssertNotNil(actualResult)
        XCTAssertEqual(actualResult!, "helloMom")
    }

    func test_getAsInt_returnsInt() {
        let actualResult = env.getAsInt("MOCK_INT")

        XCTAssertNotNil(actualResult)
        XCTAssertEqual(actualResult!, 42)
    }

    func test_getAsBool_returnsBool() {
        let actualResult = env.getAsBool("MOCK_BOOL")

        XCTAssertNotNil(actualResult)
        XCTAssertTrue(actualResult!)
    }

    func test_comments_AreStripped() {
        let actualResult = env.get("# example comment")

        XCTAssertNil(actualResult)
    }

    func test_emptyLines_AreStripped() {
        let actualResult = env.get("\r\n")

        XCTAssertNil(actualResult)
    }

    func test_all_containsTestEnv() {
        let actual = env.all()

        XCTAssertTrue(actual.contains(where: { (key, _) -> Bool in
            return key == "MOCK_STRING"
        }))
        XCTAssertTrue(actual.contains(where: { (key, _) -> Bool in
            return key == "MOCK_INT"
        }))
        XCTAssertTrue(actual.contains(where: { (key, _) -> Bool in
            return key == "MOCK_BOOL"
        }))
    }
}
