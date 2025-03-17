//
//  NetworkError+Extension.swift
//  PCNetwork
//
//  Created by summercat on 3/18/25.
//

// NetworkError+Extensions.swift
import Foundation
import Alamofire

extension NetworkError {
    /// 상태 코드와 데이터로부터 NetworkError 생성
    static func from(statusCode: Int, data: Data?) -> NetworkError {
        let apiError: APIErrorModel? = try? JSONDecoder().decode(APIErrorModel.self, from: data ?? Data())
        
        switch statusCode {
        case 400: return .badRequest(error: apiError)
        case 401: return .unauthorized(error: apiError)
        case 403: return .forbidden
        case 404: return .notFound
        case 500: return .internalServerError
        default: return .statusCode(statusCode)
        }
    }
    
    /// Alamofire AFError에서 NetworkError 추출 또는 변환
    static func from(afError: AFError) -> NetworkError {
        // 저장된 NetworkError 추출 시도
        if case .requestAdaptationFailed(let underlyingError) = afError,
           let networkError = underlyingError as? NetworkError {
            return networkError
        }
        
        if case .requestRetryFailed(let retryError, _) = afError,
           let networkError = retryError as? NetworkError {
            return networkError
        }
        
        // 상태 코드 기반 에러 변환
        if let responseCode = afError.responseCode {
            return NetworkError.from(statusCode: responseCode, data: nil)
        }
        
        // 에러 유형별 처리
        if afError.isResponseSerializationError {
            return .decodingFailed
        } else if afError.isParameterEncodingError {
            return .encodingFailed
        } else if afError.isSessionTaskError {
            if let urlError = afError.underlyingError as? URLError {
                switch urlError.code {
                case .notConnectedToInternet, .networkConnectionLost:
                    return .statusCode(-1009)
                case .timedOut:
                    return .statusCode(-1001)
                default:
                    return .statusCode(urlError.code.rawValue)
                }
            }
        }
        
        return .statusCode(-1)
    }
}
