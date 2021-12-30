//
//  PrivacyViewController.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/11/06.
//

import UIKit


class PrivacyViewController: UIViewController {
    
    @IBOutlet weak var privacyTitleLabel: UILabel!
    @IBOutlet weak var privacySubTitleLabel: UILabel!
    @IBOutlet weak var privacyScrollView: UIView!
    @IBOutlet weak var privacyMainTitleLabel: UILabel!
    @IBOutlet weak var privacySecondTitleLabel: UILabel!
    @IBOutlet weak var privacySecondMainTitleLabel: UILabel!
    @IBOutlet weak var privacyThirdTitleLabel: UILabel!
    @IBOutlet weak var privacyThirdMainTitleLabel: UILabel!
    @IBOutlet weak var privacyFourthTitleLabel: UILabel!
    @IBOutlet weak var privacyFourthMainTitleLabel: UILabel!
    @IBOutlet weak var privacyFifthTitleLabel: UILabel!
    @IBOutlet weak var privacyFifthMainTitleLabel: UILabel!
    @IBOutlet weak var privacySixthTitleLabel: UILabel!
    @IBOutlet weak var privacySixthMainTitleLabel: UILabel!
    @IBOutlet weak var privacySeventhTitleLabel: UILabel!
    @IBOutlet weak var privacySeventhMainTItleLabel: UILabel!
    @IBOutlet weak var privacyEighthTitleLabel: UILabel!
    @IBOutlet weak var privacyEighthMainTitleLabel: UILabel!
    @IBOutlet weak var privacyNinthTitleLabel: UILabel!
    @IBOutlet weak var privacyNinthMainTitleLabel: UILabel!
    @IBOutlet weak var privacyTenthTitleLabel: UILabel!
    @IBOutlet weak var privacyTenthMainTitleLabel: UILabel!
    @IBOutlet weak var privacyElevenTitleLabel: UILabel!
    @IBOutlet weak var privacyElevenMainTitleLabel: UILabel!
    @IBOutlet weak var privacyTwelveTitleLabel: UILabel!
    @IBOutlet weak var privacyTwelveMainTitleLabel: UILabel!
    @IBOutlet weak var privacyThirteenTitleLabel: UILabel!
    @IBOutlet weak var privacyThirteenMainTitleLabel: UILabel!
    @IBOutlet weak var privacyFourteenTitleLabel: UILabel!
    @IBOutlet weak var privacyFourteenMainTitleLabel: UILabel!
    @IBOutlet weak var privacyFifteenTitleLabel: UILabel!
    @IBOutlet weak var privacyFifteenMainTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayoutInit()
        setNavigationBarInit()
    }
    
    public func setNavigationBarInit() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigationArrow.png"), style: .plain, target: self, action: #selector(self.backButtonDidTap))
        let navigationApp = UINavigationBarAppearance()
        navigationApp.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = navigationApp
        self.navigationController?.navigationBar.compactAppearance = navigationApp
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 18),.foregroundColor: UIColor.gray333]
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.title = "개인정보 처리 방침"
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    public func setLayoutInit() {
        privacyTitleLabel.text = "오늘의 나 개인정보 보호약관"
        privacyTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        privacyTitleLabel.textAlignment = .left
        privacyTitleLabel.textColor = .gray333
        
        privacySubTitleLabel.text = "1. 개인정보의 처리 목적"
        privacySubTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        privacySubTitleLabel.textAlignment = .left
        privacySubTitleLabel.textColor = .gray333
        
        privacyMainTitleLabel.text = """
오늘의 나 서비스(이하 오늘의 나)는 다음의 목적을 위하여 개인정보를 처리하고 있으며, 다음의 목적 이외의 용도로는 이용하지 않습니다.
            
① 회원관리
이용 목적 : 서비스 이용에 따른 본인 식별, 인증을 위한 단말기의 고유 정보
불량 회원의 부정 이용 방지와 비인가 사용 방지, 중복 가입 방지
고객 상담, 불만 처리 등의 민원 처리
공지사항 전달

② 마케팅 및 광고의 활용
이용자에게 최적화된 서비스 제공
고객 관심사에 부합하는 콘텐츠 제공
접속 빈도 파악, 서비스 이용 현황 통계 및 분석
"""
        privacyMainTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        privacyMainTitleLabel.textAlignment = .left
        privacyMainTitleLabel.textColor = .gray555
        privacyMainTitleLabel.numberOfLines = 0
        privacyMainTitleLabel.lineBreakMode = .byCharWrapping
        
        privacySecondTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        privacySecondTitleLabel.textAlignment = .left
        privacySecondTitleLabel.textColor = .gray333
        privacySecondTitleLabel.text = "2. 개인정보의 처리 및 보유 기간"
        
        privacySecondMainTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        privacySecondMainTitleLabel.textColor = .gray555
        privacySecondMainTitleLabel.text = """
① 오늘의 나 이용자의 개인정보를 수집하는 경우 그 보유기간은 회원가입 후 해지(탈퇴 신청, 직권 탈퇴 포함)시까지 입니다. 또한 탈퇴시 오늘의 나는 이용자의 수집된 개인정보가 열람 또는 이용될 수 없도록 파기처리 합니다.

② 이용자의 개인정보는 회원가입 해지 시 또는 제공 목적 달성 후 별도의 DB로 옮겨져 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라 일정 기간 보관된 후 기록을 재생할 수 없는 기술적 방법에 의하여 영구삭제됩니다. 별도 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 보유 이외의 다른 목적으로 이용되지 않습니다.
"""
        privacySecondMainTitleLabel.numberOfLines = 0
        privacySecondMainTitleLabel.lineBreakMode = .byCharWrapping
        privacySecondMainTitleLabel.textAlignment = .left
        
        privacyThirdTitleLabel.text = "3. 개인정보의 제3자 제공"
        privacyThirdTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        privacyThirdTitleLabel.textColor = .gray333
        privacyThirdTitleLabel.textAlignment = .left
        
        privacyThirdMainTitleLabel.text = "오늘의 나는 정보주체의 별도 동의, 법률의 특별한 규정 등 개인정보 보호법 제17조에 해당하는 경우 외에는 개인정보를 제3자에게 제공하지 않습니다."
        privacyThirdMainTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        privacyThirdMainTitleLabel.textAlignment = .left
        privacyThirdMainTitleLabel.textColor = .gray555
        privacyThirdMainTitleLabel.numberOfLines = 0
        privacyThirdMainTitleLabel.lineBreakMode = .byCharWrapping
        
        privacyFourthTitleLabel.text = "4. 정보주체의 행사 권리"
        privacyFourthTitleLabel.textColor = .gray333
        privacyFourthTitleLabel.textAlignment = .left
        privacyFourthTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        
        privacyFourthMainTitleLabel.text = """
정보주체는 오늘의 나에 대해 언제든지 다음 각 호의 개인정보보호 관련 권리를 행사할 수 있습니다.

① 개인정보 열람 요구
② 오류 등이 있을 경우 정정 요구
③ 삭제요구
④ 처리정지 요구
"""
        privacyFourthMainTitleLabel.textColor = .gray555
        privacyFourthMainTitleLabel.textAlignment = .left
        privacyFourthMainTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        privacyFourthMainTitleLabel.numberOfLines = 0
        privacyFourthMainTitleLabel.lineBreakMode = .byCharWrapping

        privacyFifthTitleLabel.text = "5. 처리하는 개인정보의 항목 작성"
        privacyFifthTitleLabel.textColor = .gray333
        privacyFifthTitleLabel.textAlignment = .left
        privacyFifthTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        
        privacyFifthMainTitleLabel.text = """
오늘의 나는 다음의 개인정보 항목을 처리하고 있습니다.

① 필수항목 : 서비스 이용 기록, 접속 로그, 암호화된 단말기의 고유 정보, 이메일, 생년월일 등 소셜 로그인을 통한 얻게되는 정보
② 선택항목 : 성별
"""
        privacyFifthMainTitleLabel.textColor = .gray555
        privacyFifthMainTitleLabel.textAlignment = .left
        privacyFifthMainTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        privacyFifthMainTitleLabel.numberOfLines = 0
        privacyFifthMainTitleLabel.lineBreakMode = .byCharWrapping
        
        privacySixthTitleLabel.text = "5. 개인정보의 파기"
        privacySixthTitleLabel.textColor = .gray333
        privacySixthTitleLabel.textAlignment = .left
        privacySixthTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        
        privacySixthMainTitleLabel.textColor = .gray555
        privacySixthMainTitleLabel.textAlignment = .left
        privacySixthMainTitleLabel.text = """
오늘의 나는 원칙적으로 개인정보 처리목적이 달성된 경우에는 지체 없이 해당 개인정보를 파기합니다. 파기의 절차, 기한 및 방법은 다음과 같습니다.

① 파기 절차 : 이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다.
② 파기 기한 : 이용자의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다.
"""
        privacySixthMainTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        privacySixthMainTitleLabel.numberOfLines = 0
        privacySixthMainTitleLabel.lineBreakMode = .byCharWrapping
        
        
        privacySeventhTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        privacySeventhTitleLabel.textColor = .gray333
        privacySeventhTitleLabel.textAlignment = .left
        privacySeventhTitleLabel.text = "7. 해킹 등에 대비한 기술적 대책"
        
        privacySeventhMainTItleLabel.text = """
오늘의 나는 해킹이나 컴퓨터 바이러스 등에 의한 개인정보 유출 및 훼손을 막기 위하여 보안프로그램을 설치하고 주기적인 갱신∙점검을 하며 외부로부터 접근이 통제된 구역에 시스템을 설치하고 기술적/물리적으로 감시 및 차단하고 있습니다.
"""
        privacySeventhMainTItleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        privacySeventhMainTItleLabel.textColor = .gray555
        privacySeventhMainTItleLabel.numberOfLines = 0
        privacySeventhMainTItleLabel.lineBreakMode = .byCharWrapping
        privacySeventhMainTItleLabel.textAlignment = .left
        
        
        privacyEighthTitleLabel.text = "8. 개인정보에 대한 접근 제한"
        privacyEighthTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        privacyEighthTitleLabel.textColor = .gray333
        privacyEighthTitleLabel.textAlignment = .left
        
        
        privacyEighthMainTitleLabel.text = """
개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여, 변경, 말소를 통하여 개인정보에 대한 접근통제조치를 하고 있으며 침입자차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.
"""
        privacyEighthMainTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        privacyEighthMainTitleLabel.textColor = .gray555
        privacyEighthMainTitleLabel.textAlignment = .left
        privacyEighthMainTitleLabel.numberOfLines = 0
        privacyEighthMainTitleLabel.lineBreakMode = .byCharWrapping
        
        privacyNinthTitleLabel.text = "9. 접속기록의 보관 및 위변조 방지"
        privacyNinthTitleLabel.textColor = .gray333
        privacyNinthTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        privacyNinthTitleLabel.textAlignment = .left
        
        privacyNinthMainTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        privacyNinthMainTitleLabel.text = "개인정보처리시스템에 접속한 기록을 최소 6개월 이상 보관, 관리하고 있으며, 접속 기록이 위변조 및 도난, 분실되지 않도록 보안기능을 사용하고 있습니다."
        privacyNinthMainTitleLabel.textAlignment = .left
        privacyNinthMainTitleLabel.numberOfLines = 0
        privacyNinthMainTitleLabel.textColor = .gray555
        privacyNinthMainTitleLabel.lineBreakMode = .byCharWrapping
        
        privacyTenthTitleLabel.text = "10. 문서보안을 위한 잠금장치 사용"
        privacyTenthTitleLabel.textColor = .gray333
        privacyTenthTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        privacyTenthTitleLabel.textAlignment = .left
        
        privacyTenthMainTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        privacyTenthMainTitleLabel.text = "개인정보가 포함된 서류, 보조저장매체 등을 잠금장치가 있는 안전한 장소에 보관하고 있습니다."
        privacyTenthMainTitleLabel.textAlignment = .left
        privacyTenthMainTitleLabel.textColor = .gray555
        privacyTenthMainTitleLabel.lineBreakMode = .byCharWrapping
        privacyTenthMainTitleLabel.numberOfLines = 0
        
        privacyElevenTitleLabel.text = "11. 비인가자에 대한 출입 통제"
        privacyElevenTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        privacyElevenTitleLabel.textColor = .gray333
        privacyElevenTitleLabel.textAlignment = .left
        
        privacyElevenMainTitleLabel.text = "개인정보를 보관하고 있는 물리적 보관 장소를 별도로 두고 이에 대해 출입통제 절차를 수립, 운영하고 있습니다."
        privacyElevenMainTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        privacyElevenMainTitleLabel.textAlignment = .left
        privacyElevenMainTitleLabel.textColor = .gray555
        privacyElevenMainTitleLabel.lineBreakMode = . byCharWrapping
        privacyElevenMainTitleLabel.numberOfLines = 0
        
        privacyTwelveTitleLabel.text = "12. 개인정보 보호책임자"
        privacyTwelveTitleLabel.textColor = .gray333
        privacyTwelveTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        privacyTwelveTitleLabel.textAlignment = .left
        
        privacyTwelveMainTitleLabel.text = """
① 프로젝트성 그룹 오늘의 나는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.


▶ 개인정보 보호책임자

성명 : 최석호
직책 : 팀리더
연락처 : buybutton.official@gmail.com
▶ 개인정보 보호 담당부서

부서명 : 개인정보 보호 팀
담당자 : 최석호
연락처 : buybutton.official@gmail.com

② 정보주체는 오늘의 나를 이용하면서 발생한 모든 개인정보 보호 관련 문의, 불만 처리, 피해구제 등에 관한 사항을 개인정보 보호 책임자 및 담당부서로 문의할 수 있습니다. 프로젝트성 그룹 오늘의 나는 정보주체의 문의에 대해 지체 없이 답변 및 처리할 의무가 있습니다.
"""
        privacyTwelveMainTitleLabel.textAlignment = .left
        privacyTwelveMainTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        privacyTwelveMainTitleLabel.textColor = .gray333
        privacyTwelveMainTitleLabel.numberOfLines = 0
        privacyTwelveMainTitleLabel.lineBreakMode = .byCharWrapping
        
        privacyThirteenTitleLabel.text = "13. 개인정보 열람청구"
        privacyThirteenTitleLabel.textColor = .gray333
        privacyThirteenTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        privacyThirteenTitleLabel.textAlignment = .left
        
        privacyThirteenMainTitleLabel.text = """
① 정보주체는 개인정보 보호법 제35조에 따른 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다. 오늘의 나는 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다.

▶ 개인정보 열람청구 접수∙처리 부서

부서명 : 개인정보 보호 팀
담당자 : 최석호
연락처 : buybutton.official@gmail.com

② 정보주체는 제1항의 열람청구 접수∙처리부서 이외에, 행정안전부의 ‘개인정보보호 종합지원 포털 웹사이트(www.privacy.go.kr)를 통해서도 개인정보 열람청구를 할 수 있습니다.
▶ 행정안전부 개인정보보호 종합지원 포털 → 개인정보 민원 → 개인정보 열람등 요구 (본인확인을 위하여 아이핀(I-PIN)이 있어야 함)
"""
        privacyThirteenMainTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        privacyThirteenMainTitleLabel.textAlignment = .left
        privacyThirteenMainTitleLabel.textColor = .gray555
        privacyThirteenMainTitleLabel.lineBreakMode = . byCharWrapping
        privacyThirteenMainTitleLabel.numberOfLines = 0
        
        privacyFourteenTitleLabel.text = "14. 개인정보 열람청구"
        privacyFourteenTitleLabel.textColor = .gray333
        privacyFourteenTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        privacyFourteenTitleLabel.textAlignment = .left
        
        
        privacyFourteenMainTitleLabel.text = """
아래의 기관은 오늘의 나와는 별개의 기관으로서 오늘의 나의 자체적인 개인정보 불만처리, 피해구제 결과에 만족하지 못하거나 보다 자세한 도움이 필요하다면 문의∙이용할 수 있습니다.

▶ 개인정보 침해신고센터 (한국인터넷진흥원 운영)

- 소관업무 : 개인정보 침해사실 신고, 상담 신청
- 홈페이지 : privacy.kisa.or.kr
- 전화 : (국번없이) 118
- 주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터

▶ 개인정보 분쟁조정위원회 (한국인터넷진흥원 운영)
- 소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결)
- 홈페이지 : privacy.kisa.or.kr
- 전화 : (국번없이) 118
- 주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터

▶ 대검찰청 사이버범죄수사단 : 02-3480-3573 (www.spo.go.kr)

▶ 경찰청 사이버범죄수사단 : 1566-0112 (www.netan.go.kr)
"""
        privacyFourteenMainTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        privacyFourteenMainTitleLabel.textAlignment = .left
        privacyFourteenMainTitleLabel.textColor = .gray555
        privacyFourteenMainTitleLabel.lineBreakMode = . byCharWrapping
        privacyFourteenMainTitleLabel.numberOfLines = 0
        
        
        privacyFifteenTitleLabel.text = "15. 개인정보 처리방침 변경"
        privacyFifteenTitleLabel.textColor = .gray333
        privacyFifteenTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        privacyFifteenTitleLabel.textAlignment = .left
        
        
        privacyFifteenMainTitleLabel.text = "개인정보 처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항 시행 7일 전부터 공지사항을 통해 고지합니다."
        privacyFifteenMainTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        privacyFifteenMainTitleLabel.textAlignment = .left
        privacyFifteenMainTitleLabel.textColor = .gray555
        privacyFifteenMainTitleLabel.lineBreakMode = . byCharWrapping
        privacyFifteenMainTitleLabel.numberOfLines = 0
        
    
    }
        
    @objc
    private func backButtonDidTap(){
        self.navigationController?.popViewController(animated: true)
    }
}
