//
//  UserManager.swift
//  Qutoes-App
//
//  Created by Siri Kaarvik Slyk on 11/06/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser: Codable {
    
    let userId: String
    let photoUrl: String?
    let dateCreated: Date?
    var isPremium: Bool?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.isPremium = false
    }
    
    init(
        userId: String,
        photoUrl: String? = nil,
        dateCreated: Date? = nil,
        isPremium: Bool? = nil
    ) {
        self.userId = userId
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        self.isPremium = isPremium
    }
    
    /*func togglePremiumStatus() -> DBUser{
        let currentValue = isPremium ?? false
        return DBUser(
            userId: userId,
            photoUrl: photoUrl,
            dateCreated: dateCreated,
            isPremium: !currentValue)
    }*/
    
    mutating func togglePremiumStatus() {
        let currentValue = isPremium ?? false
        isPremium = !currentValue
    }
}

final class UserManager {
    
    static let shared = UserManager()
    private init() { }
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)
    }
    
    /*func createNewUser(auth: AuthDataResultModel) async throws {
     var userData : [String:Any] = [
     "user_id": auth.uid,
     "date_created": Timestamp(),
     ]
     if let photoURL = auth.photoUrl {
     userData["photo_url"] =  photoURL
     }
     
     try await userDocument(userId: auth.uid).setData(userData, merge: false)
     
     }*/
    
    func getUser(userId: String) async throws -> DBUser {
        return try await userDocument(userId: userId).getDocument(as: DBUser.self, decoder: decoder)
    }
    
    /*func getUser(userId: String) async throws -> DBUser {
     let snapshot = try await userDocument(userId: userId).getDocument()
     
     guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
     throw URLError(.badServerResponse)
     }
     
     
     let photoUrl = data["photo_url"] as? String
     let dateCreated = data["date_created"] as? Date
     
     return DBUser(userId: userId, photoUrl: photoUrl, dateCreated: dateCreated)
     }*/
    
    func updateUserPremiumStatus(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)
    }
}
