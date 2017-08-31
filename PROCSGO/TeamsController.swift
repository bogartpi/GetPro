//
//  MainController.swift
//  PROCSGO
//
//  Created by Pavel Bogart on 24/07/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit
import Social

private let cellId = "cellId"

class TeamsController: UICollectionViewController {
    
    var teams: [Team]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Rosters"
        changeNavigationTintColor(.white)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        fetchData()
        customizeNavController()
        collectionView?.backgroundColor = UIColor.customGrayColor
        collectionView?.register(TeamsCell.self, forCellWithReuseIdentifier: cellId)
        setCellLayout()
    }
    
    private func setCellLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        layout.itemSize = CGSize(width: view.frame.width/3, height: view.frame.width/3)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView?.collectionViewLayout = layout
    }
    
    private func fetchData() {
        if let jsonPath: String = Bundle.main.path(forResource: "csgonew", ofType: "json"), let jsonData: Data = NSData(contentsOfFile: jsonPath) as Data? {
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as AnyObject
                if let data: Array<AnyObject> = json.value(forKeyPath: "teams") as? Array<AnyObject> {
                    var teamsArray = [Team]()
                    for jsonTeam in data {
                        var playersArray = [Player]()
                        let json = jsonTeam as! [String: Any]
                        let team = Team()
                        team.logo = json["logo"] as? String
                        team.id = json["id"] as? String
                        team.name = json["name"] as? String
                        for player in json["players"] as! [[String: Any]] {
                            let currentPlayer = parseSinglePlayer(json: player)
                            playersArray.append(currentPlayer)
                        }
                        team.players = playersArray
                        teamsArray.append(team)
                    }
                    teams = teamsArray
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func parseSinglePlayer(json: [String: Any]) -> Player {
        let player = Player()
        player.alias = json["alias"] as? String
        player.name = json["name"] as? String
        player.age = json["age"] as? String
        player.country = json["country"] as? String
        player.imageName = json["playerImage"] as? String
        
        for singleInfo in json["info"] as! [[String: Any]] {
            let currentInfo = parseSinglePlayerInfo(json: singleInfo)
            player.info = currentInfo
        }
        return player
    }
    
    func parseSinglePlayerInfo(json: [String: Any]) -> Info {
        let info = Info()
        var arrayScreenshots = [String]()
        var arrayPovs = [String]()
        var arrayGears = [String]()
        
        for screenshot in json["screenshots"] as! [String] {
            arrayScreenshots.append(screenshot)
        }
        info.screenshots = arrayScreenshots
        
        for pov in json["povs"] as! [String] {
            arrayPovs.append(pov)
        }
        info.povs = arrayPovs
        
        for gear in json["gear"] as! [String] {
            arrayGears.append(gear)
        }
        info.gears = arrayGears
        
        info.cfg = parseConfig(json: json["cfg"] as! [String: Any])
        return info
    }
    
    func parseConfig(json: [String: Any]) -> Config {
        let config = Config()
        var mouseCfgArray = [String]()
        var monitorCfgArray = [String]()
        var crossConfigArray = [String]()
        for mouseCfg in json["mouseSettings"] as! [String] {
            mouseCfgArray.append(mouseCfg)
        }
        for monitorCfg in json["monitorSettings"] as! [String] {
            monitorCfgArray.append(monitorCfg)
        }
        for crossCfg in json["crosshaircfg"] as! [String] {
            crossConfigArray.append(crossCfg)
        }
        config.mouseSettings = mouseCfgArray
        config.monitorSettings = monitorCfgArray
        config.crosshaircfg = crossConfigArray
        return config
    }
    
}

extension TeamsController: UICollectionViewDelegateFlowLayout {
    
    private func showPlayersController(index: Int) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 14
        let playersVC = PlayersController(collectionViewLayout: layout)
        playersVC.team = teams?[index]
        navigationController?.pushViewController(playersVC, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = teams?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TeamsCell
        if let logo = teams?[indexPath.item].logo {
            cell.imageView.image = UIImage(named: logo)
        }
        if let teamName = teams?[indexPath.item].name {
            cell.teamNameLabel.text = teamName
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 3) - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showPlayersController(index: indexPath.item)
    }
}
