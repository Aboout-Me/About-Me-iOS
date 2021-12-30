//
//  TermsViewController.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/11/21.
//

import UIKit


class TermsViewController: UIViewController {
    
    @IBOutlet weak var termsContanierView: UIView!
    @IBOutlet weak var termsMainTitleLabel: UILabel!
    @IBOutlet weak var termsFirstTitleLabel: UILabel!
    @IBOutlet weak var termsFirstContentLabel: UILabel!
    @IBOutlet weak var termsSecondTitleLabel: UILabel!
    @IBOutlet weak var termsSecondContentLabel: UILabel!
    @IBOutlet weak var termsThirdTitleLabel: UILabel!
    @IBOutlet weak var termsThirdContentLabel: UILabel!
    @IBOutlet weak var termsFourthTitleLabel: UILabel!
    @IBOutlet weak var termsFourthContentLabel: UILabel!
    @IBOutlet weak var termsFifthTitleLabel: UILabel!
    @IBOutlet weak var termsFifthContentLabel: UILabel!
    @IBOutlet weak var termsSixthTitleLabel: UILabel!
    @IBOutlet weak var termsSixthContentLabel: UILabel!
    @IBOutlet weak var termsSeventhTitleLabel: UILabel!
    @IBOutlet weak var termsSeventhContentLabel: UILabel!
    @IBOutlet weak var termsEighthTitleLabel: UILabel!
    @IBOutlet weak var termsEighthContentLabel: UILabel!
    @IBOutlet weak var termsNinthTitleLabel: UILabel!
    @IBOutlet weak var termsNinthContentLabel: UILabel!
    @IBOutlet weak var termsTenthTitleLabel: UILabel!
    @IBOutlet weak var termsTenthCotentLabel: UILabel!
    @IBOutlet weak var termsElevenTitleLabel: UILabel!
    @IBOutlet weak var termsElevenContentLabel: UILabel!
    @IBOutlet weak var termsTwelveTitleLabel: UILabel!
    @IBOutlet weak var termsTwelveContentLabel: UILabel!
    @IBOutlet weak var termsThirteenTitleLabel: UILabel!
    @IBOutlet weak var termsThirteenContentLabel: UILabel!
    @IBOutlet weak var termsFourteenTitleLabel: UILabel!
    @IBOutlet weak var termsFourteenContentLabel: UILabel!
    @IBOutlet weak var termsFifteenTitleLabel: UILabel!
    @IBOutlet weak var termsFifteenContentLabel: UILabel!
    
    
    override func viewDidLoad() {
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
        self.navigationItem.title = "서비스 이용약관"
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    public func setLayoutInit() {
        termsMainTitleLabel.text = "오늘의 나 이용약관"
        termsMainTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        termsMainTitleLabel.textAlignment = .left
        termsMainTitleLabel.textColor = .gray333
        
        termsFirstTitleLabel.text = "제 1조 (목적)"
        termsFirstTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termsFirstTitleLabel.textAlignment = .left
        termsFirstTitleLabel.textColor = .gray333
        
        termsFirstContentLabel.text = """
본 약관은 프로젝트성 그룹 오늘의 나가 제공하는 오늘의 나 관련 제반 서비스(이하 ‘서비스’) 및 콘텐츠 이용과 관련하여 회사와 회원과의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.
"""
        termsFirstContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        termsFirstContentLabel.textColor = .gray555
        termsFirstContentLabel.textAlignment = .left
        termsFirstContentLabel.lineBreakMode = .byCharWrapping
        termsFirstContentLabel.numberOfLines = 0
        
        
        termsSecondTitleLabel.text = "제 2조 (정의)"
        termsSecondTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termsSecondTitleLabel.textAlignment = .left
        termsSecondTitleLabel.textColor = .gray333
        
        termsSecondContentLabel.text = """
① ‘회사’란 프로젝트성 그룹 오늘의 나 팀을 뜻합니다.
② ‘서비스’란 회사가 제작 및 운영을 하고 있는 각종 웹사이트, SMS, API, 알림 이메일, 애플리케이션, 버튼 및 위젯을 비롯한 서비스 일체를 말합니다.
③ ‘회원’이란 회사가 제공하는 서비스에 접속하여 본 약관에 따라 회사의 이용절차에 동의하고 회사가 제공하는 서비스를 이용하는 이용자를 말합니다.
④ ‘콘텐츠’란 회원이 서비스에 접근하여 생성하거나 볼 수 있는 이미지, 텍스트, 음악, 동영상, 프로그램, 기타 코드 정보를 말합니다.
"""
        
        termsSecondContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        termsSecondContentLabel.textColor = .gray555
        termsSecondContentLabel.textAlignment = .left
        termsSecondContentLabel.numberOfLines = 0
        termsSecondContentLabel.lineBreakMode = .byCharWrapping
        
        termsThirdTitleLabel.text = "제 3조 (약관 등의 명시와 설명 및 개정)"
        termsThirdTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termsThirdTitleLabel.textColor = .gray333
        termsThirdTitleLabel.textAlignment = .left
        
        termsThirdContentLabel.text = """
① 회사는 본 약관의 내용을 회원이 알 수 있도록 서비스 내에 게시함으로써 이를 공지합니다.
② 회사는 콘텐츠산업 진흥법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 약관의 규제에 관한 법률, 소비자기본법 등 관련 법령을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.
③ 회사가 약관을 개정할 경우에는 개정약관 및 개정약관의 시행일자와 개정사유를 명시하여 그 시행일자 15일 전부터 시행일 이후 상당한 기간 동안 본 서비스 페이지에 게시하며, 개정된 약관은 그 시행일에 효력이 발생합니다. 단, 개정 내용이 회원에게 불리한 경우에는 그 시행일자 30일 전부터 시행일 이후 상당한 기간 동안 본 서비스 페이지에 게시하거나 팝업화면을 게시하는 등 이용자가 충분히 인지할 수 있는 합리적으로 가능한 방법으로 공지하며, 개정된 약관은 그 시행일에 효력이 발생됩니다.
④ 회사가 전항에 따라 회원에게 통지하면서 공지일로부터 개정약관 시행일까지 거부의사를 표시하지 아니하면 승인한 것으로 본다는 뜻을 명확하게 고지하였음에도 불구하고 회원의 거부의 의사표시가 없는 경우에는 변경된 약관에 동의한 것으로 봅니다. 회원이 개정약관에 동의하지 않을 경우 회원은 7조 1항의 규정에 따라 이용계약을 해지할 수 있습니다.
"""
        termsThirdContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        termsThirdContentLabel.textColor = .gray555
        termsThirdContentLabel.textAlignment = .left
        termsThirdContentLabel.numberOfLines = 0
        termsThirdContentLabel.lineBreakMode = .byCharWrapping
        
        
        termsFourthTitleLabel.text = "제 4조 (서비스의 제공 및 변경)"
        termsFourthTitleLabel.textColor = .gray333
        termsFourthTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termsFourthTitleLabel.textAlignment = .left
        
        termsFourthContentLabel.text = """
① 회사는 회원에게 회사가 자체 개발하거나 다른 회사와의 협력계약 등을 통해 제작한 일체의 서비스를 제공합니다.
② 회사는 서비스의 내용 및 제공일자를 제 8조에서 정한 방법으로 회원에게 통지하고, 본 조 제1항에 정한 서비스를 변경하여 제공할 수 있습니다.
"""
        termsFourthContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        termsFourthContentLabel.textColor = .gray555
        termsFourthContentLabel.textAlignment = .left
        termsFourthContentLabel.numberOfLines = 0
        termsFourthContentLabel.lineBreakMode = .byCharWrapping
        
        termsFifthTitleLabel.text = "제 5조 (서비스의 중단)"
        termsFifthTitleLabel.textColor = .gray333
        termsFifthTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termsFifthTitleLabel.textAlignment = .left
        
        
        termsFifthContentLabel.text = """
① 회사는 컴퓨터 등 정보통신설비의 보수점검∙교체 및 고장, 통신 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.
② 새로운 서비스로 교체하거나, 기타 회사가 적절하다고 판단하는 사유에 기하여 현재 제공하는 서비스를 완전히 중단할 수 있습니다.
"""
        termsFifthContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        termsFifthContentLabel.textColor = .gray555
        termsFifthContentLabel.textAlignment = .left
        termsFifthContentLabel.numberOfLines = 0
        termsFifthContentLabel.lineBreakMode = .byCharWrapping
        
        termsSixthTitleLabel.text = "제 6조 (회원가입)"
        termsSixthTitleLabel.textColor = .gray333
        termsSixthTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termsSixthTitleLabel.textAlignment = .left
        
        termsSixthContentLabel.text = """
① 이용자는 오늘의 나가 정한 가입 양식에 따라 회원정보를 기입한 후 본 약관에 동의한다는 의사표시를 함으로서 회원가입을 완료합니다.
② 회사는 이용자가 서비스 회원가입 페이지의 ‘동의’ 혹은 ‘확인’ 버튼을 클릭하거나 이용자가 본 서비스의 이용을 시작한 경우 본 약관에 동의한 것으로 간주합니다.
"""
        termsSixthContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        termsSixthContentLabel.textColor = .gray555
        termsSixthContentLabel.textAlignment = .left
        termsSixthContentLabel.numberOfLines = 0
        termsSixthContentLabel.lineBreakMode = .byCharWrapping
        
        termsSeventhTitleLabel.text = "제 7조 (회원 탈퇴 및 자격 상실 등)"
        termsSeventhTitleLabel.textColor = .gray333
        termsSeventhTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termsSeventhTitleLabel.textAlignment = .left
        
        termsSeventhContentLabel.text = """
① 회원은 회사에 언제든지 탈퇴를 요청할 수 있으며, 회사는 즉시 회원탈퇴를 처리합니다.
② 회원 탈퇴가 이루어지면 회원이 작성한 콘텐츠는 회원과의 연결이 모두 끊겨 연관 관계가 없어지게 됩니다.
③ 회사는 서비스를 이용하는 사용자가 제 11조 1항을 반복적으로 위배할 경우 적절한 조치를 통해 자격을 임시 정지하거나 상실시킬 수 있습니다.
"""
        termsSeventhContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        termsSeventhContentLabel.textColor = .gray555
        termsSeventhContentLabel.textAlignment = .left
        termsSeventhContentLabel.numberOfLines = 0
        termsSeventhContentLabel.lineBreakMode = .byCharWrapping
        
        termsEighthTitleLabel.text = "제 8조 (회원에 대한 통지)"
        termsEighthTitleLabel.textColor = .gray333
        termsEighthTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termsEighthTitleLabel.textAlignment = .left
        
        
        termsEighthContentLabel.text = "회사는 불특정다수 회원에 대한 통지의 경우 1주일 이상 공지사항 게시판에 게시함으로써 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다."
        termsEighthContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        termsEighthContentLabel.textColor = .gray555
        termsEighthContentLabel.textAlignment = .left
        termsEighthContentLabel.numberOfLines = 0
        termsEighthContentLabel.lineBreakMode = .byCharWrapping
        
        termsNinthTitleLabel.text = "제 9조 (개인정보의 보호 및 관리)"
        termsNinthTitleLabel.textColor = .gray333
        termsNinthTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termsNinthTitleLabel.textAlignment = .left
        
        termsNinthContentLabel.text = """
① 회사는 서비스를 제공하기 위하여 회원으로부터 서비스 이용에 필요한 개인정보를 수집할 수 있습니다.
② 회사는 관련 법령이 정하는 바에 따라 회원의 개인정보를 보호하기 위해 노력하며, 회원의 개인정보의 보호 및 사용에 대해서는 회사가 별도로 고지하는 개인정보 처리방침을 적용합니다.
③ 회사는 회사의 귀책 없이 회원의 귀책사유로 인하여 회원의 정보가 노출된 경우 이에 대해서는 책임을 지지 않습니다.
"""
        termsNinthContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        termsNinthContentLabel.textColor = .gray555
        termsNinthContentLabel.textAlignment = .left
        termsNinthContentLabel.numberOfLines = 0
        termsNinthContentLabel.lineBreakMode = .byCharWrapping
        
        termsTenthTitleLabel.text = "제 10조 (회사의 의무)"
        termsTenthTitleLabel.textColor = .gray333
        termsTenthTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termsTenthTitleLabel.textAlignment = .left
        
        
        termsTenthCotentLabel.text = """
① 회사는 법령과 본 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며, 본 약관이 정하는 바에 따라 지속적이고 안정적인 서비스를 제공하기 위해 노력합니다.
② 회사는 회원의 이메일로 회원이 수신에 동의하지 아니한 영리 목적의 광고성 전자우편을 발송하지 아니합니다.
③ 회사는 회원이 서비스를 이용함에 있어 회원에게 법률적인 증명이 가능한 고의 또는 중대한 과실을 입힐 경우 이로 인한 손해를 배상할 책임이 있습니다.
"""
        termsTenthCotentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        termsTenthCotentLabel.textColor = .gray555
        termsTenthCotentLabel.textAlignment = .left
        termsTenthCotentLabel.numberOfLines = 0
        termsTenthCotentLabel.lineBreakMode = .byCharWrapping
        
        
        termsElevenTitleLabel.text = "제 11조 (회원의 의무)"
        termsElevenTitleLabel.textColor = .gray333
        termsElevenTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termsElevenTitleLabel.textAlignment = .left
        
        termsElevenContentLabel.text = """
① 회원은 다음 각 호의 행위를 하여서는 안됩니다.

1. 회사 및 제3자의 명예를 훼손하거나 지식재산권을 침해하는 등 회사나 제3자의 권리를 침해하는 행위 2. 회사의 서비스에 게시된 정보를 변경하거나 서비스를 이용하여 얻은 정보를 회사의 사전 승낙 없이 영리 또는 비영리의 목적으로 복제·출판·방송 등에 사용하거나 제3자에게 제공하는 행위 3. 회사가 제공하는 서비스를 이용하여 제3자에게 본인을 홍보할 기회를 제공하거나 제3자의 홍보를 대행하는 등의 방법으로 금전을 수수하거나 서비스를 이용할 권리를 양도하고 이를 대가로 금전을 수수하는 행위 4. 외설 또는 폭력적인 메시지·화상·음성 등이 담긴 내용을 게시하거나 공공질서 또는 공서양속에 반하는 정보를 공개 또는 게시하는 행위 5. 정보통신망법 등 관련 법령에 의하여 그 전송 또는 게시가 금지되는 정보(컴퓨터 프로그램 등)를 전송·게시하거나 청소년보호법에서 규정하는 청소년유해매체물을 게시하는 행위 6. 컴퓨터 소프트웨어, 하드웨어, 전기통신 장비의 정상적인 가동을 방해·파괴할 목적으로 고안된 소프트웨어 바이러스, 기타 다른 컴퓨터 코드·파일·프로그램을 포함하고 있는 자료를 게시하거나 다른 회원에게 발송하는 행위 7. 스토킹(stalking). 스팸성 댓글의 게재 등 다른 회원의 정상적인 서비스 이용을 방해하는 행위 8. 다른 회원의 개인정보를 그 동의 없이 수집·저장·공개하는 행위 9. 광고 또는 선전 등 영리 목적으로 서비스를 이용하는 행위 10. 회사가 제공하는 소프트웨어 등을 개작하거나 리버스 엔지니어링, 디컴파일, 디스어셈블 하는 행위 11. 본 약관 및 회사가 규정한 서비스 운영정책을 위반하는 행위

② 회사는 회원이 전항 각 호의 행위를 하는 경우 해당 게시물 등을 삭제 또는 임시조치할 수 있고 회원의 서비스 이용을 제한하거나 그 사유가 중대한 경우 일방적으로 본 계약을 해지할 수 있습니다.
③ 회원이 본 조 제1항 각 호의 행위를 함으로써 회사에 손해가 발생한 경우, 회사는 해당 회원에 대해 손해배상을 청구할 수 있습니다.
④ 본 서비스 내에서 회사의 관여 없이 회원 간 이루어지는 일체의 행위(거래 행위 포함)와 관련하여 발생하는 모든 의무와 책임은 해당 회원에게 있으며, 회사는 그 내용에 대하여 책임을 지지 않습니다.
"""
        termsElevenContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        termsElevenContentLabel.textColor = .gray555
        termsElevenContentLabel.textAlignment = .left
        termsElevenContentLabel.numberOfLines = 0
        termsElevenContentLabel.lineBreakMode = .byCharWrapping
        
        
        termsTwelveTitleLabel.text = "제 12조 (콘텐츠의 삭제 또는 이용제한)"
        termsTwelveTitleLabel.textColor = .gray333
        termsTwelveTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termsTwelveTitleLabel.textAlignment = .left
        
        termsTwelveContentLabel.text = """
① 회원이 게시한 콘텐츠의 내용이 다음 각 호에 해당하는 경우 회사는 해당 콘텐츠에 대한 접근을 임시적으로 차단하거나 영구적으로 삭제하는 조치를 취할 수 있습니다.

1. 다른 회원 또는 제3자를 비방하거나 중상모략으로 명예를 손상시키는 내용 2. 음란물, 욕설 등 공서양속에 위반되는 내용의 정보, 문장, 그림 등을 유포하는 내용 3. 범죄행위와 관련이 있다고 판단되는 내용 4. 다른 회원 또는 제3자의 저작권 등 기타 권리를 침해하는 내용 5. 종교적, 정치적 분쟁을 야기하는 내용으로서, 이러한 분쟁으로 인하여 회사의 업무에 방해된다고 판단하는 경우 6. 타인의 개인정보, 사생활을 침해하거나 명예를 손상시키는 경우 7. 동일한 내용을 중복하여 다수 게시하는 등 게시의 목적에 어긋나는 경우 8. 불필요하거나 승인되지 않은 광고, 판촉물을 게재하는 경우

② 회원이 작성한 콘텐츠로 인한 법률상 이익 침해를 근거로, 다른 회원 또는 제3자가 회원 또는 회사를 대상으로 하여 민형사사의 법적 조치(예: 고소, 가처분신청, 손해배상청구소송)를 취하는 동시에 법적 조치와 관련된 게시물의 삭제를 요청해오는 경우, 회사는 동 법적 조치의 결과(예: 검찰의 기소, 법원의 가처분결정, 손해배상판결)가 있을 때까지 관련 게시물에 대한 접근을 잠정적으로 제한할 수 있습니다.
"""
        termsTwelveContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        termsTwelveContentLabel.textColor = .gray555
        termsTwelveContentLabel.textAlignment = .left
        termsTwelveContentLabel.numberOfLines = 0
        termsTwelveContentLabel.lineBreakMode = .byCharWrapping
        
        termsThirteenTitleLabel.text = "제 13조 (권리의 귀속 및 저작물의 이용)"
        termsThirteenTitleLabel.textColor = .gray333
        termsThirteenTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termsThirteenTitleLabel.textAlignment = .left
        
        termsThirteenContentLabel.text = """
① 회사가 회원에게 제공하는 서비스에 대한 지식재산권을 포함한 일체의 권리는 회사에 귀속됩니다.
② 회원은 회사가 제공하는 서비스를 이용함으로써 얻은 정보를 회사의 사전승낙 없이 복제, 전송, 출판, 배포, 방송, 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.
③ 회원이 서비스 내에 게시한 게시물의 저작권은 게시한 회원에게 귀속됩니다. 단, 회사는 서비스의 운영, 전시, 전송, 배포, 홍보의 목적으로 회원에게 별도의 허락 없이 무상으로 저작권법에 규정하는 공정한 관행에 합치되게 합리적인 범위 내에서 다음과 같이 회원이 등록한 게시물을 사용할 수 있습니다.

1. 서비스 내에서 회원 게시물을 복제, 수정, 개조, 전시, 전송, 배포 및 저작물성을 해치지 않는 범위 내에서의 편집 저작물 작성 2. 미디어, 통신사 등 서비스 제휴 파트너에게 회원의 게시물 내용을 제공, 전시 혹은 홍보하게 하는 것. 3. 회사는 전항 이외의 방법으로 회원의 게시물을 이용하고자 하는 경우, 전화, 팩스, 전자우편 등의 방법을 통해 사전에 회원의 동의를 얻어야 합니다.
"""
        termsThirteenContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        termsThirteenContentLabel.textColor = .gray555
        termsThirteenContentLabel.textAlignment = .left
        termsThirteenContentLabel.numberOfLines = 0
        termsThirteenContentLabel.lineBreakMode = .byCharWrapping
        
        termsFourteenTitleLabel.text = "제 14조 (약관의 개정)"
        termsFourteenTitleLabel.textColor = .gray333
        termsFourteenTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termsFourteenTitleLabel.textAlignment = .left
        
        termsFourteenContentLabel.text = """
① 회사는 약관규제등에관한법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진등에관한법률 등 관련법을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.
② 다만, 개정 내용이 회원에게 불리할 경우에는 적용일자 30일 이전부터 적용일자 전일까지 공지합니다.
③ 회원은 변경된 약관에 대해 거부할 권리가 있습니다. 회원은 변경된 약관이 공지된 후 15일 이내에 거부의사를 표명할 수 있습니다. 회원이 거부하는 경우 회사는 당해 회원과의 계약을 해지할 수 있습니다. 만약 회원이 변경된 약관이 공지된 후 15일 이내에 거부의사를 표시하지 않는 경우에는 동의하는 것으로 간주합니다.
"""
        termsFourteenContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        termsFourteenContentLabel.textColor = .gray555
        termsFourteenContentLabel.textAlignment = .left
        termsFourteenContentLabel.numberOfLines = 0
        termsFourteenContentLabel.lineBreakMode = .byCharWrapping
    
        termsFifteenTitleLabel.text = "제 15조 (재판관할)"
        termsFifteenTitleLabel.textColor = .gray333
        termsFifteenTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        termsFifteenTitleLabel.textAlignment = .left
        
        termsFifteenContentLabel.text = "회사와 회원간에 발생한 서비스 이용에 관한 분쟁에 대하여는 대한민국 법을 적용하며, 본 분쟁으로 인한 소송은 민사소송법상의 관할을 가지는 대한민국의 법원에 제기합니다."
        termsFifteenContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        termsFifteenContentLabel.textColor = .gray555
        termsFifteenContentLabel.textAlignment = .left
        termsFifteenContentLabel.numberOfLines = 0
        termsFifteenContentLabel.lineBreakMode = .byCharWrapping
    }
    
    @objc
    public func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}
