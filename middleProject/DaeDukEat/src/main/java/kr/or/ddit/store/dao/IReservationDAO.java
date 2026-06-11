// Source code is decompiled from a .class file using FernFlower decompiler (from Intellij IDEA).
package kr.or.ddit.store.dao;

import java.util.List;
import kr.or.ddit.store.vo.ReservationVO;

public interface IReservationDAO {
   List<ReservationVO> selectActiveReservations(String var1) throws Exception;

   List<ReservationVO> selectRecentReservations(String var1) throws Exception;

   ReservationVO selectReservationById(Long var1) throws Exception;

   int updateReservationStatus(Long var1, String var2) throws Exception;

   int cancelReservation(Long var1) throws Exception;
}
