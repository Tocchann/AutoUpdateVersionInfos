// DispThisVerMFCDlg.cpp : 実装ファイル
//

#include "pch.h"
#include "DispThisVerMFC.h"
#include "DispThisVerMFCDlg.h"
#include <atlpath.h>

#pragma comment(lib, "VERSION.LIB" )

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CDispThisVerMFCDlg ダイアログ



CDispThisVerMFCDlg::CDispThisVerMFCDlg(CWnd* pParent /*=nullptr*/)
	: CDialog(IDD_DISPTHISVERMFC_DIALOG, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CDispThisVerMFCDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CDispThisVerMFCDlg, CDialog)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
END_MESSAGE_MAP()


// CDispThisVerMFCDlg メッセージ ハンドラー

BOOL CDispThisVerMFCDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// このダイアログのアイコンを設定します。アプリケーションのメイン ウィンドウがダイアログでない場合、
	//  Framework は、この設定を自動的に行います。
	SetIcon(m_hIcon, TRUE);			// 大きいアイコンの設定
	SetIcon(m_hIcon, FALSE);		// 小さいアイコンの設定

	// TODO: 初期化をここに追加します。


	TCHAR modulePath[MAX_PATH];
	::GetModuleFileName( nullptr, modulePath, MAX_PATH );
	auto verInfoSize = ::GetFileVersionInfoSize( modulePath, nullptr );
	if( verInfoSize > 0 )
	{
		auto verInfo = new BYTE[verInfoSize];
		if( ::GetFileVersionInfo( modulePath, 0, verInfoSize, verInfo ) )
		{
			VS_FIXEDFILEINFO* pFileInfo = nullptr;
			UINT fileInfoSize = 0;
			if( ::VerQueryValue( verInfo, TEXT( "\\" ), (LPVOID*)&pFileInfo, &fileInfoSize ) )
			{
				CString strVersion;
				strVersion.Format( TEXT( "%d.%d.%d.%d" ),
					HIWORD( pFileInfo->dwFileVersionMS ),
					LOWORD( pFileInfo->dwFileVersionMS ),
					HIWORD( pFileInfo->dwFileVersionLS ),
					LOWORD( pFileInfo->dwFileVersionLS ) );
				SetDlgItemText( IDC_STC_VERSION_MFC, strVersion );
			}
		}
		delete[]verInfo;
	}
	*(ATLPath::FindFileName( modulePath )-1) = L'\0';
	CString configName = ATLPath::FindFileName( modulePath );
	CPath path;
	path.Combine( modulePath, TEXT( "..\\..\\") + configName + _T("\\net9.0\\DispThisVerNetCore.exe" ) );
	verInfoSize = ::GetFileVersionInfoSize( path, nullptr );
	if( verInfoSize > 0 )
	{
		auto verInfo = new BYTE[verInfoSize];
		if( ::GetFileVersionInfo( path, 0, verInfoSize, verInfo ) )
		{
			VS_FIXEDFILEINFO* pFileInfo = nullptr;
			UINT fileInfoSize = 0;
			if( ::VerQueryValue( verInfo, TEXT( "\\" ), (LPVOID*)&pFileInfo, &fileInfoSize ) )
			{
				CString strVersion;
				strVersion.Format( TEXT( "%d.%d.%d.%d" ),
					HIWORD( pFileInfo->dwFileVersionMS ),
					LOWORD( pFileInfo->dwFileVersionMS ),
					HIWORD( pFileInfo->dwFileVersionLS ),
					LOWORD( pFileInfo->dwFileVersionLS ) );
				SetDlgItemText( IDC_STC_VERSION_NETCORE, strVersion );
			}
		}
		delete[]verInfo;
	}

	path.Combine( modulePath, TEXT( "..\\..\\AnyCPU\\" ) + configName + _T( "\\DispThisVerNetFx.exe" ) );
	verInfoSize = ::GetFileVersionInfoSize( path, nullptr );
	if( verInfoSize > 0 )
	{
		auto verInfo = new BYTE[verInfoSize];
		if( ::GetFileVersionInfo( path, 0, verInfoSize, verInfo ) )
		{
			VS_FIXEDFILEINFO* pFileInfo = nullptr;
			UINT fileInfoSize = 0;
			if( ::VerQueryValue( verInfo, TEXT( "\\" ), (LPVOID*)&pFileInfo, &fileInfoSize ) )
			{
				CString strVersion;
				strVersion.Format( TEXT( "%d.%d.%d.%d" ),
					HIWORD( pFileInfo->dwFileVersionMS ),
					LOWORD( pFileInfo->dwFileVersionMS ),
					HIWORD( pFileInfo->dwFileVersionLS ),
					LOWORD( pFileInfo->dwFileVersionLS ) );
				SetDlgItemText( IDC_STC_VERSION_NETFX, strVersion );
			}
		}
		delete[]verInfo;
	}

	return TRUE;  // フォーカスをコントロールに設定した場合を除き、TRUE を返します。
}

// ダイアログに最小化ボタンを追加する場合、アイコンを描画するための
//  下のコードが必要です。ドキュメント/ビュー モデルを使う MFC アプリケーションの場合、
//  これは、Framework によって自動的に設定されます。

void CDispThisVerMFCDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 描画のデバイス コンテキスト

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// クライアントの四角形領域内の中央
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// アイコンの描画
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// ユーザーが最小化したウィンドウをドラッグしているときに表示するカーソルを取得するために、
//  システムがこの関数を呼び出します。
HCURSOR CDispThisVerMFCDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

