import ConfidentialKit
import Parsing

struct EncryptionTechniqueParser: Parser {

    typealias Technique = SourceSpecification.ObfuscationStep.Technique

    private typealias Algorithm = Obfuscation.Encryption.SymmetricEncryptionAlgorithm

    func parse(_ input: inout Substring) throws -> Technique {
        try Parse(Technique.encryption(algorithm:)) {
            Parse {
                Whitespace(.horizontal)
                C.Parsing.Keywords.encrypt
                Whitespace(1..., .horizontal)
                C.Parsing.Keywords.using
                Whitespace(1..., .horizontal)
            }
            OneOf {
                for algorithm in Algorithm.allCases {
                    algorithm.description.map { algorithm }
                }
            }
            End()
        }.parse(&input)
    }
}
