//
//  CharacterCoreDataWorker.swift
//  TestRnM
//
//  Created by Anderen on 03.04.2025.
//

import CoreData

protocol CharacterCoreDataWorkerProtocol {
    func loadFromCoreData(completion: @escaping ([Character]) -> Void)
    func saveToCoreData(characters: [Character])
}

final class CharacterCoreDataWorker: CharacterCoreDataWorkerProtocol {

    private let coreDataStack = CoreDataStack.shared

    func loadFromCoreData(completion: @escaping ([Character]) -> Void) {
        let fetchRequest: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()

        do {
            let characterEntities = try coreDataStack.context.fetch(fetchRequest)
            let charactersFromCoreData = characterEntities.map { characterEntity -> Character in
                return Character(
                    id: characterEntity.id,
                    name: characterEntity.name ?? "",
                    species: characterEntity.species ?? "",
                    image: characterEntity.image ?? "",
                    status: Status(rawValue: characterEntity.status ?? "") ?? Status.unknown
                )
            }
            completion(charactersFromCoreData)
        } catch {
            completion([])
        }
    }

    func saveToCoreData(characters: [Character]) {
        for character in characters {
            let characterEntity = CharacterEntity(context: coreDataStack.context)
            characterEntity.id = character.id
            characterEntity.name = character.name
            characterEntity.species = character.species
            characterEntity.image = character.image
        }
        coreDataStack.saveContext()
    }
}
